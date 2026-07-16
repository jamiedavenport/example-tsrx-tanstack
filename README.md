[![TSRX & TanStack Start](./assets/banner.png)](https://tanstack-start-app.jxd.workers.dev)

An example wiring [TSRX](https://tsrx.dev) into [TanStack Start](https://tanstack.com/start) — and the SSR seams we found along the way.

Read the story behind it: [Wiring TSRX into TanStack Start, and the SSR seams we found](https://www.jxd.dev/blog/tsrx-tanstack-start)

**Live demo:** [tanstack-start-app.jxd.workers.dev](https://tanstack-start-app.jxd.workers.dev)

## Setup

1. Install `@tsrx/react` and `@tsrx/vite-plugin-react`, and add the plugin to `vite.config.ts` ahead of `@vitejs/plugin-react`.
2. Install `@tsrx/typescript-plugin` so TypeScript understands `.tsrx` syntax, and register it under `compilerOptions.plugins` in `tsconfig.json`.
3. Add `**/*.tsrx` to `tsconfig.json`'s `include` so the language service picks the files up.
4. Install the [Ripple TS VS Code extension](https://marketplace.visualstudio.com/items?itemName=Ripple-TS.ripple-ts-vscode-plugin) for syntax highlighting.

## Stress test

`/stress` has one page per TSRX language feature (`src/routes/stress/*.tsx`), each backed by a dedicated `.tsrx` component under `src/components/`: statement containers, `@if`/`@else`, `@for`/`@empty`/`key`, `@switch`/`@case`/`@default`, `@try`/`@catch`, lazy destructuring (`&{ }`), scoped styles with CSS custom properties and `:global()`, dynamic tag names, and hooks called inside `@if`/`@for` branches.

## Issues found

None of these are hard to work around today — see the sections below for the details and workarounds.

### SSR CSS

TSRX's scoped `<style>` blocks don't appear in the initial SSR HTML in dev; they only show up after client hydration (FOUC). Confirmed dev-only — production `vite build` output renders the scoped CSS correctly via Rollup's CSS chunking, which doesn't go through the buggy dev-mode collector below.

Root cause is in `@tanstack/start-plugin-core`, not TSRX:

- `@tsrx/vite-plugin-react` emits a real static `import "<id>?tsrx-css&lang.css"` and resolves it to a virtual module id prefixed with `\0` (standard Rollup/Vite convention).
- Vite's module graph always sets `mod.file = cleanUrl(resolvedId)`, which strips the query string. For the TSRX virtual module this leaves `\0/…/button.tsrx` — ending in `.tsrx`, not `.css`.
- `@tanstack/start-plugin-core`'s dev stylesheet collector (`dist/esm/vite/dev-server-plugin/dev-styles.js`, serves `/@tanstack-start/styles.css?routes=...`) tests each module dependency with `isCssFile(dep.file ?? dep.url)`. Since `dep.file` is truthy but doesn't end in `.css`, the check fails and falls through silently — it never checks `dep.url`, which does end in `...lang.css`. The CSS is dropped from the SSR response.
- The client bundle still imports the CSS module directly, so it applies once hydration executes it — hence the FOUC.

Not TSRX-specific: any plugin using the "extension lives only in the query string" virtual-module pattern (e.g. Vue SFC `<style>` blocks, `Component.vue?vue&type=style&lang.css`) would hit the same bug under TanStack Start's dev CSS collector.

Proposed upstream fix: in `dev-styles.js`, check `isCssFile(dep.url) || isCssFile(dep.file)` (or just prefer `.url`) instead of `isCssFile(dep.file ?? dep.url)`.

**Workaround:** none needed for production; if you need to eyeball styling in dev, use `vite build && vite preview` instead of `vite dev`.

### Route file extensions

`.tsrx` files can't be used as route files — only as components a route imports and renders.

`@tanstack/router-generator`'s directory walker (`dist/esm/filesystem/physical/getRouteNodes.js:73`) hardcodes which extensions count as route files:

```js
else if (fullPath.match(/\.(tsx|ts|jsx|js|vue)$/)) {
```

`.tsrx` doesn't match, and there's no documented config option to extend this list (`routeFilePrefix`/`routeFileIgnorePrefix`/`routeFileIgnorePattern` filter by name, not extension; `addExtensions` only rewrites the extension in already-generated import paths). Notably `.vue` is already hardcoded in here alongside the JS/TS extensions, with dedicated handling elsewhere in `generator.js` (`isVueFile` checks) — so there's precedent for a non-`.tsx` route extension, it's just not generalized into a config option.

Upstream fix would be either hardcoding `.tsrx` alongside `.vue` (narrow) or generalizing this into a `routeFileExtensions` config option (better, benefits any similar tool). Bigger change than the CSS fix since route-type/layout/lazy-route detection all key off filename patterns derived from this regex — not attempted yet.

**Workaround:** keep route files as `.tsx`, import `.tsrx` components from them.

### `@try`/`@catch` does not protect SSR

`@tsrx/react` compiles `@try`/`@catch` to a perfectly ordinary React class component (`@tsrx/react/src/error-boundary.js`, `TsrxErrorBoundary`) using `static getDerivedStateFromError`. That's the fundamental problem: **React error boundaries never activate during server rendering** — `getDerivedStateFromError`/`componentDidCatch` are a client-render-only mechanism. This isn't a TSRX-specific bug so much as an inherited, well-known React limitation that TSRX's `@try`/`@catch` docs don't mention.

Reproduced at `/stress/try-catch`, where `Bomb` throws unconditionally by default: the response is a 200, but the entire `<body>` is replaced by React 19's `<template data-msg="Switched to client rendering because the server rendering errored...">` bail-out marker — not just the `try`/`catch` subtree. Confirmed via `curl`; every other stress page renders normally (checked by grepping all responses for that marker).

The blast radius is the whole page, not just the boundary, because there's no `<Suspense>` immediately wrapping the throwing subtree — the error propagates to the *outermost* Suspense boundary (around the whole route match, per the stack trace: `TryCatchDemo → Suspense → OutletImpl → ... → RouterProvider → StartServer`), so the entire document's SSR output gets discarded in favor of full client-side rendering.

Once mounted purely client-side, the error boundary works exactly as intended (this is just normal React behavior, not something TSRX has to implement).

Two independent things worth upstreaming to TSRX:

- Document that `@try`/`@catch` cannot protect the SSR pass — it's a client-only recovery mechanism, same as any hand-written error boundary.
- Consider having the compiled output wrap each `@try` block in its own `<Suspense>` boundary, so a throw during SSR only blanks that boundary's subtree instead of the entire page.

**Workaround:** don't rely on `@try`/`@catch` alone to keep an SSR response alive; anything it wraps that can throw during render needs its own upstream handling (data fetched before render, a Suspense boundary you control, etc).

### Scoped `<style>` blocks scope to their own function, not the whole file

`/stress/scoped-styles` originally put the `<style>` block in `ScopedStylesDemo` while the `.badge`-classed element it styled lived in a separate `Badge` function in the same file. Result: none of the `.badge` CSS ever applied — not just the `--badge-color` custom property, the whole rule.

Root cause: the scoping hash class only gets merged onto elements within the *same function* that contains the `<style>` block, not file-wide. Confirmed by inspecting the actual SSR output — elements inside `Badge` rendered as plain `class="badge"` with no hash suffix at all, while unrelated elements from a different file's component (`stress-nav.tsrx`) correctly carried *that* file's hash everywhere. After moving the `<style>` block into `Badge` itself (the function that actually renders the styled element), the hash appeared correctly (`class="badge tsrx-4fd33bbb"`), confirmed by fetching the compiled `?tsrx-css&lang.css` virtual module directly and seeing `.badge.tsrx-4fd33bbb { ... }`.

This makes sense as a design (component-level scoping, not file-level) once you know it, but it's not obvious from the docs, and the failure mode is silent — no error, no warning, the CSS rule just never matches anything.

**Workaround:** put the `<style>` block in the same function as the elements it styles, and use `:global(...)` as the escape hatch to reach a class in a different function in the same file.

## Work with us

Curious about TSRX, TanStack Start, or want help wiring something similar into your own stack? This example is built and maintained by [JXD](https://jxd.dev), a London software consultancy. We're here to help, [get in touch](https://www.jxd.dev/contact).
