import { Link } from "@tanstack/react-router";
import { STRESS_PAGES } from "#/lib/stress-pages";

export function StressNav() @{
	<nav className="stress-nav">
		<Link to="/stress">All stress tests</Link>
		<span className="sep">/</span>
		<Link to="/">Home</Link>

		<ul>
			@for (const page of STRESS_PAGES; key page.path) {
				<li>
					<Link to={page.path} activeProps={{ className: "active" }}>
						{page.title}
					</Link>
					<code>{page.feature}</code>
				</li>
			}
		</ul>

		<style>
			.stress-nav {
				border-bottom: 1px solid #ddd;
				padding-bottom: 1rem;
				margin-bottom: 1.5rem;
			}
			.sep {
				margin: 0 0.5rem;
				color: #aaa;
			}
			ul {
				list-style: none;
				padding: 0;
				margin: 0.75rem 0 0;
				display: flex;
				flex-wrap: wrap;
				gap: 0.75rem 1.5rem;
			}
			li {
				display: flex;
				flex-direction: column;
				font-size: 0.875rem;
			}
			code {
				color: #888;
			}
			:global(.active) {
				font-weight: 700;
			}
		</style>
	</nav>
}
