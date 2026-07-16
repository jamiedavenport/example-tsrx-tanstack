const HeadingTags = { level1: "h1", level2: "h2", level3: "h3" };

type DynamicTagDemoProps = {
	level: 1 | 2 | 3;
};

export function DynamicTagDemo({ level }: DynamicTagDemoProps) @{
	const IdentifierTag = level === 1 ? "h1" : level === 2 ? "h2" : "h3";
	const MemberAccessTag = HeadingTags.level2;

	<div className="demo">
		<{IdentifierTag}>Identifier tag: {IdentifierTag}</{IdentifierTag}>
		<{MemberAccessTag}>Member access tag: HeadingTags.level2</{MemberAccessTag}>
		<{"p"}>Static string tag expression</{"p"}>
	</div>
}
