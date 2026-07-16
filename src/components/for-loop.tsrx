import { useState } from "react";

type Todo = { id: number; text: string };

export function ForLoopDemo() @{
	const [items, setItems] = useState<Todo[]>([
		{ id: 1, text: "Write TSRX stress tests" },
		{ id: 2, text: "Run them against TanStack Start" },
	]);
	const [nextId, setNextId] = useState(3);

	function addItem() {
		setItems([...items, { id: nextId, text: `Item ${nextId}` }]);
		setNextId(nextId + 1);
	}

	function removeItem(id: number) {
		setItems(items.filter((item) => item.id !== id));
	}

	function clearAll() {
		setItems([]);
	}

	<div className="demo">
		<div className="controls">
			<button onClick={addItem}>Add item</button>
			<button onClick={clearAll}>Clear all</button>
		</div>

		<ul>
			@for (const item of items; index i; key item.id) {
				<li>
					{i + 1}. {item.text}
					<button onClick={() => removeItem(item.id)}>Remove</button>
				</li>
			} @empty {
				<li className="empty">No items left.</li>
			}
		</ul>

		<style>
			.controls {
				display: flex;
				gap: 0.5rem;
				margin-bottom: 0.5rem;
			}
			.empty {
				color: #888;
				font-style: italic;
			}
		</style>
	</div>
}
