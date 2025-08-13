import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final List<dynamic> cartItems;
  const OrderSummaryCard({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Qty: ${item.quantity}'),
            trailing: Text(
              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
