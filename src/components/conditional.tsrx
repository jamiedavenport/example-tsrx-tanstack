import { useState } from "react";

export function ConditionalDemo() @{
	const [expanded, setExpanded] = useState(false);

	<div className="demo">
		<button onClick={() => setExpanded(!expanded)}>
			{expanded ? "Collapse" : "Expand"}
		</button>

		@if (expanded) {
			<p className="panel">Expanded content revealed via @if/@else.</p>
		} @else {
			<p className="panel muted">Collapsed. Click to expand.</p>
		}

		<style>
			.demo {
				display: flex;
				flex-direction: column;
				gap: 0.5rem;
				align-items: flex-start;
			}
			.panel {
				padding: 0.75rem;
				border: 1px solid #ccc;
				border-radius: 4px;
			}
			.muted {
				color: #888;
			}
		</style>
	</div>
}
