import { createFileRoute } from "@tanstack/react-router";
import { StressNav } from "#/components/stress-nav.tsrx";
import { SwitchDemo } from "#/components/switch.tsrx";

export const Route = createFileRoute("/stress/switch")({ component: Page });

function Page() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">
				Switch — <code>{"@switch / @case / @default"}</code>
			</h1>
			<div className="mt-4">
				<SwitchDemo />
			</div>
		</div>
	);
}
