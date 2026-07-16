type BadgeProps = {
	color: string;
};

function Badge({ color }: BadgeProps) @{
	<span className="badge" style={{ "--badge-color": color }}>
		{color}
	</span>
}

export function ScopedStylesDemo() @{
	<div className="wrapper">
		<Badge color="crimson" />
		<Badge color="seagreen" />
		<Badge color="steelblue" />

		<style>
			.badge {
				display: inline-block;
				padding: 0.25rem 0.75rem;
				border-radius: 999px;
				background: var(--badge-color);
				color: white;
				margin-right: 0.5rem;
			}

			:global(.wrapper) {
				display: block;
				padding: 1rem;
			}
		</style>
	</div>
}
