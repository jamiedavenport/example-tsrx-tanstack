import { createFileRoute } from "@tanstack/react-router";
import { StressNav } from "#/components/stress-nav.tsrx";
import { TryCatchDemo } from "#/components/try-catch.tsrx";

export const Route = createFileRoute("/stress/try-catch")({ component: Page });

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Error handling — <code>{"@try / @catch"}</code>
			</h1>
			<div className="mt-4">
				<TryCatchDemo />
			</div>
		</div>
	);
}
