import { createFileRoute } from "@tanstack/react-router";
import { ScopedStylesDemo } from "#/components/scoped-styles.tsrx";
import { StressNav } from "#/components/stress-nav.tsrx";

export const Route = createFileRoute("/stress/scoped-styles")({
	component: Page,
});

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Scoped styles — <code>{"<style> + CSS vars + :global()"}</code>
			</h1>
			<div className="mt-4">
				<ScopedStylesDemo />
			</div>
		</div>
	);
}
