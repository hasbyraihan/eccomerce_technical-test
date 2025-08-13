import 'package:flutter/material.dart';

import '../screens/checkout_screen.dart';

/// Widget untuk menampilkan ringkasan total harga keranjang
/// dan tombol menuju halaman Checkout.
class CartSummary extends StatelessWidget {
  final double totalPrice;

  const CartSummary({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menampilkan total harga
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Tombol Checkout
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CheckoutScreen(),
                ),
              );
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
