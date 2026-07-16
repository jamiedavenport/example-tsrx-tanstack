import { createFileRoute } from "@tanstack/react-router";
import { HooksInBranchDemo } from "#/components/hooks-in-branch.tsrx";
import { StressNav } from "#/components/stress-nav.tsrx";

export const Route = createFileRoute("/stress/hooks-in-branch")({
	component: Page,
});

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Hooks in branches — <code>{"hooks inside @if / @for"}</code>
			</h1>
			<div className="mt-4">
				<HooksInBranchDemo showCounter={true} />
			</div>
		</div>
	);
}
