import 'package:ecommerce_test/features/cart/presentation/widgets/list_cart.dart';
import 'package:flutter/material.dart';

/// Widget untuk menampilkan daftar item dalam keranjang belanja.
class CartItemList extends StatelessWidget {
  final List cartItems;

  const CartItemList({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListCart(cartItem: item);
        },
      ),
    );
  }
}
