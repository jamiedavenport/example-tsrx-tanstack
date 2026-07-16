export type StressPage = {
	path: string;
	title: string;
	feature: string;
};

export const STRESS_PAGES: StressPage[] = [
	{ path: "/stress/statement-container", title: "Statement container", feature: "@{ }" },
	{ path: "/stress/conditional", title: "Conditional", feature: "@if / @else" },
	{ path: "/stress/for-loop", title: "List rendering", feature: "@for / @empty / key" },
	{ path: "/stress/switch", title: "Switch", feature: "@switch / @case / @default" },
	{ path: "/stress/try-catch", title: "Error handling", feature: "@try / @catch" },
	{ path: "/stress/lazy-destructure", title: "Lazy destructuring", feature: "&{ }" },
	{ path: "/stress/scoped-styles", title: "Scoped styles", feature: "<style> + CSS vars + :global()" },
	{ path: "/stress/dynamic-tag", title: "Dynamic tag names", feature: "<{Tag}>" },
	{ path: "/stress/hooks-in-branch", title: "Hooks in branches", feature: "hooks inside @if / @for" },
];
