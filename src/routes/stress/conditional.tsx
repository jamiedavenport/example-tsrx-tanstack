import { createFileRoute } from "@tanstack/react-router";
import { StressNav } from "#/components/stress-nav.tsrx";
import { ConditionalDemo } from "#/components/conditional.tsrx";

export const Route = createFileRoute("/stress/conditional")({ component: Page });

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Conditional — <code>{"@if / @else"}</code>
			</h1>
			<div className="mt-4">
				<ConditionalDemo />
			</div>
		</div>
	);
}
