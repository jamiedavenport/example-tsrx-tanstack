import { createFileRoute, Link } from "@tanstack/react-router";
import { StressNav } from "#/components/stress-nav.tsrx";
import { STRESS_PAGES } from "#/lib/stress-pages";

export const Route = createFileRoute("/stress/")({ component: StressIndex });

function StressIndex() {
	return (
		<div className="p-8">
			<StressNav />
			<h1 className="text-3xl font-bold">TSRX feature stress tests</h1>
			<p className="mt-2">
				One page per TSRX language feature, each backed by a `.tsrx` component.
			</p>
			<ul className="mt-4 space-y-2">
				{STRESS_PAGES.map((page) => (
					<li key={page.path}>
						<Link to={page.path} className="underline">
							{page.title}
						</Link>{" "}
						<code>{page.feature}</code>
					</li>
				))}
			</ul>
		</div>
	);
}
