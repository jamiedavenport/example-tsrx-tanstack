import { createFileRoute } from "@tanstack/react-router";
import { StressNav } from "#/components/stress-nav.tsrx";
import { ForLoopDemo } from "#/components/for-loop.tsrx";

export const Route = createFileRoute("/stress/for-loop")({ component: Page });

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				List rendering — <code>{"@for / @empty / key"}</code>
			</h1>
			<div className="mt-4">
				<ForLoopDemo />
			</div>
		</div>
	);
}
