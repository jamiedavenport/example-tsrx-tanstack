import { createFileRoute } from "@tanstack/react-router";
import { StressNav } from "#/components/stress-nav.tsrx";
import { LazyDestructureDemo } from "#/components/lazy-destructure.tsrx";

export const Route = createFileRoute("/stress/lazy-destructure")({ component: Page });

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Lazy destructuring — <code>{"&{ }"}</code>
			</h1>
			<div className="mt-4">
				<LazyDestructureDemo name="Ada Lovelace" age={36} />
			</div>
		</div>
	);
}
