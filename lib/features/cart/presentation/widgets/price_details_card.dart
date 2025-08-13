import 'package:flutter/material.dart';

class PriceDetailsCard extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double total;
  final ThemeData theme;

  const PriceDetailsCard({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _priceRow("Subtotal", '\$${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            _priceRow("Delivery Price", '\$${shippingFee.toStringAsFixed(2)}'),
            const Divider(height: 24),
            _priceRow(
              "Total",
              '\$${total.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {TextStyle? style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: style ?? const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
