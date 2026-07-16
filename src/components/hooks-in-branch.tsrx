import { useState } from "react";

type Item = { id: number; label: string };

const ITEMS: Item[] = [
	{ id: 1, label: "First" },
	{ id: 2, label: "Second" },
	{ id: 3, label: "Third" },
];

export function HooksInBranchDemo({ showCounter }: { showCounter: boolean }) @{
	<div className="demo">
		@if (showCounter) {
			const [count, setCount] = useState(0);
			<button onClick={() => setCount(count + 1)}>Count: {count}</button>
		} @else {
			<p>Counter hidden.</p>
		}

		<ul>
			@for (const item of ITEMS; key item.id) {
				const [open, setOpen] = useState(false);
				<li onClick={() => setOpen(!open)}>
					{item.label}: {open ? "expanded" : "collapsed"}
				</li>
			}
		</ul>
	</div>
}
