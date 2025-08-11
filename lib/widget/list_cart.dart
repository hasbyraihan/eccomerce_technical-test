import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../providers/cart_providers.dart'; // sesuaikan path

class ListCart extends ConsumerWidget {
  final CartItem cartItem;

  const ListCart({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = cartItem.price * cartItem.quantity;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),

            const SizedBox(width: 12),

            // Info title, quantity dan subtotal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Row quantity dengan tombol minus dan plus
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (cartItem.quantity > 1) {
                            ref.read(cartProvider.notifier).updateQuantity(
                              cartItem,
                              cartItem.quantity - 1,
                            );
                          }
                        },
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          ref.read(cartProvider.notifier).updateQuantity(
                            cartItem,
                            cartItem.quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Text(
                    'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Tombol hapus
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ref.read(cartProvider.notifier).removeItem(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${cartItem.title} dihapus dari keranjang')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
