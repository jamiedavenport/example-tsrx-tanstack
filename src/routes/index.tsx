import { createFileRoute } from "@tanstack/react-router";
import { Button } from "../components/button.tsrx";

export const Route = createFileRoute("/")({ component: Home });

function Home() {
	console.log("Hello, World!");

	return (
		<div className="p-8">
			<h1 className="text-4xl font-bold">Welcome to TanStack Start</h1>
			<p className="mt-4 text-lg">
				Edit <code>src/routes/index.tsx</code> to get started.
			</p>
			<Button
				label="Click Me"
				onClick={() => {
					console.log("Hello World!");
				}}
			/>
		</div>
	);
}
