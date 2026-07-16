import { useState } from "react";

type Status = "idle" | "loading" | "success" | "error";

const STATUSES: Status[] = ["idle", "loading", "success", "error"];

export function SwitchDemo() @{
	const [status, setStatus] = useState<Status>("idle");

	function cycle() {
		const nextIndex = (STATUSES.indexOf(status) + 1) % STATUSES.length;
		setStatus(STATUSES[nextIndex]);
	}

	<div className="demo">
		<button onClick={cycle}>Next status (currently: {status})</button>

		@switch (status) {
			@case "idle": {
				<p>Idle. Click to start.</p>
			}
			@case "loading": {
				<p>Loading...</p>
			}
			@case "success": {
				<p className="success">Done!</p>
			}
			@default: {
				<p className="error">Something went wrong.</p>
			}
		}

		<style>
			.success {
				color: green;
			}
			.error {
				color: red;
			}
		</style>
	</div>
}
