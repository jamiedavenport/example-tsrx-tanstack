import { useState } from "react";

function Bomb({ shouldThrow }: { shouldThrow: boolean }) {
	if (shouldThrow) {
		throw new Error("Boom: component intentionally threw.");
	}
	return <p>No explosion this time.</p>;
}

export function TryCatchDemo() @{
	const [shouldThrow, setShouldThrow] = useState(true);

	<div className="demo">
		<button onClick={() => setShouldThrow(!shouldThrow)}>
			Toggle throw (currently: {String(shouldThrow)})
		</button>

		@try {
			<Bomb shouldThrow={shouldThrow} />
		} @catch (e, reset) {
			<div className="error-box">
				<p>Error: {e.message}</p>
				<button
					onClick={() => {
						setShouldThrow(false);
						reset();
					}}
				>
					Try again
				</button>
			</div>
		}

		<style>
			.error-box {
				border: 1px solid red;
				padding: 0.75rem;
				border-radius: 4px;
			}
		</style>
	</div>
}
