type OrderSummaryProps = {
	unitPrice: number;
	quantity: number;
};

export function StatementContainerDemo({ unitPrice, quantity }: OrderSummaryProps) @{
	const subtotal = unitPrice * quantity;
	const tax = subtotal * 0.08;
	const total = subtotal + tax;

	function formatCurrency(value: number) {
		return `$${value.toFixed(2)}`;
	}

	<dl className="summary">
		<dt>Unit price</dt>
		<dd>{formatCurrency(unitPrice)}</dd>
		<dt>Quantity</dt>
		<dd>{quantity}</dd>
		<dt>Subtotal</dt>
		<dd>{formatCurrency(subtotal)}</dd>
		<dt>Tax (8%)</dt>
		<dd>{formatCurrency(tax)}</dd>
		<dt>Total</dt>
		<dd>{formatCurrency(total)}</dd>
	</dl>
}
