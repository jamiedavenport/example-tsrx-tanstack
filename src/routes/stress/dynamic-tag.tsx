import { createFileRoute } from "@tanstack/react-router";
import { DynamicTagDemo } from "#/components/dynamic-tag.tsrx";
import { StressNav } from "#/components/stress-nav.tsrx";

export const Route = createFileRoute("/stress/dynamic-tag")({
	component: Page,
});

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Dynamic tag names — <code>{"<{Tag}>"}</code>
			</h1>
			<div className="mt-4">
				<DynamicTagDemo level={2} />
			</div>
		</div>
	);
}
