type ButtonProps = {
    label: string;
    onClick: () => void;
}

export function Button ({label, onClick}: ButtonProps) @{
    <button {onClick} className="text-red-500">{label}</button>
}