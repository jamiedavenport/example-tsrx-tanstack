type UserCardProps = {
	name: string;
	age: number;
};

export function LazyDestructureDemo(&{ name, age }: UserCardProps) {
	return (
		<div className="card">
			<h2>{name}</h2>
			<p>Age: {age}</p>
		</div>
	);
}
