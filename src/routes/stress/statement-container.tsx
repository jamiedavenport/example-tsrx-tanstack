import { createFileRoute } from "@tanstack/react-router";
import { StatementContainerDemo } from "#/components/statement-container.tsrx";
import { StressNav } from "#/components/stress-nav.tsrx";

export const Route = createFileRoute("/stress/statement-container")({
	component: Page,
});

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Statement container — <code>{"@{ }"}</code>
			</h1>
			<div className="mt-4">
				<StatementContainerDemo unitPrice={19.99} quantity={3} />
			</div>
		</div>
	);
}
