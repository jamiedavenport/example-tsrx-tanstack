# TanStack x TSRX Example

## Log

1. Install `@tsrx/react` and `@tsrx/vite-plugin-react`. Replace in the Vite config.
1. Install https://marketplace.visualstudio.com/items?itemName=Ripple-TS.ripple-ts-vscode-plugin for editor support.
1. Install `@tsrx/typescript-plugin` so that Typescript understands TSRX syntax.

## TanStack Changes

### SSR CSS

TSRX's scoped `<style>` blocks don't appear in the initial SSR HTML in dev; they only show up after client hydration (FOUC).

Root cause is in `@tanstack/start-plugin-core`, not TSRX:

- `@tsrx/vite-plugin-react` emits a real static `import "<id>?tsrx-css&lang.css"` and resolves it to a virtual module id prefixed with `\0` (standard Rollup/Vite convention).
- Vite's module graph always sets `mod.file = cleanUrl(resolvedId)`, which strips the query string. For the TSRX virtual module this leaves `\0/…/button.tsrx` — ending in `.tsrx`, not `.css`.
- `@tanstack/start-plugin-core`'s dev stylesheet collector (`dist/esm/vite/dev-server-plugin/dev-styles.js`, serves `/@tanstack-start/styles.css?routes=...`) tests each module dependency with `isCssFile(dep.file ?? dep.url)`. Since `dep.file` is truthy but doesn't end in `.css`, the check fails and falls through silently — it never checks `dep.url`, which does end in `...lang.css`. The CSS is dropped from the SSR response.
- The client bundle still imports the CSS module directly, so it applies once hydration executes it — hence the FOUC.

Not TSRX-specific: any plugin using the "extension lives only in the query string" virtual-module pattern (e.g. Vue SFC `<style>` blocks, `Component.vue?vue&type=style&lang.css`) would hit the same bug under TanStack Start's dev CSS collector.

Proposed upstream fix: in `dev-styles.js`, check `isCssFile(dep.url) || isCssFile(dep.file)` (or just prefer `.url`) instead of `isCssFile(dep.file ?? dep.url)`.

Unverified: whether this also affects production `vite build` (likely not, since Rollup's CSS chunking doesn't use this dev-only heuristic).