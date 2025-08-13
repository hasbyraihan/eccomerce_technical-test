import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_providers.dart';
import '../widgets/cart_summary.dart';
import '../widgets/cart_item_list.dart';

/// [CartScreen] menampilkan daftar item yang ada di keranjang belanja.
/// Menggunakan Riverpod untuk sinkronisasi state keranjang.
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = _calculateTotal(cartItems);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body:
          cartItems.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cart_empty.png',
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Your Cart is Empty',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  CartItemList(cartItems: cartItems),
                  CartSummary(totalPrice: totalPrice),
                ],
              ),
    );
  }

  double _calculateTotal(List cartItems) {
    return cartItems.fold<double>(
      0,
      (previousValue, item) => previousValue + (item.price * item.quantity),
    );
  }
}
