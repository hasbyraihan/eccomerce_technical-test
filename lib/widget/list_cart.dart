import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../providers/cart_providers.dart';

class ListCart extends ConsumerWidget {
  final CartItem cartItem;

  const ListCart({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final subtotal = cartItem.price * cartItem.quantity;

    return Card(
      color: Colors.grey[100],
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                cartItem.image,
                width: 90,
                height: 90,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 90),
              ),
            ),
            const SizedBox(width: 12),

            // 2. Kolom Info dan Aksi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Baris Title dan Tombol Hapus ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          cartItem.title,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Tombol hapus yang lebih subtle
                      InkWell(
                        onTap: () {
                          ref.read(cartProvider.notifier).removeItem(cartItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${cartItem.title} dihapus dari keranjang')),
                          );
                        },
                        child: const Icon(Icons.close, color: Colors.grey, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // --- Harga Satuan ---
                  Text(
                    '\$${cartItem.price.toStringAsFixed(2)} / item',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 12),

                  // --- Baris Kontrol Kuantitas dan Subtotal ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Kontrol Kuantitas (Stepper)
                      _buildQuantityStepper(ref, theme),
                      // Subtotal
                      Text(
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk Kontrol Kuantitas (Stepper)
  Widget _buildQuantityStepper(WidgetRef ref, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Tombol Kurang
          SizedBox(
            width: 32,
            height: 32,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                if (cartItem.quantity > 1) {
                  ref.read(cartProvider.notifier).updateQuantity(cartItem, cartItem.quantity - 1);
                }
              },
              child: const Icon(Icons.remove, size: 16),
            ),
          ),
          // Jumlah
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              cartItem.quantity.toString(),
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          // Tombol Tambah
          SizedBox(
            width: 32,
            height: 32,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                ref.read(cartProvider.notifier).updateQuantity(cartItem, cartItem.quantity + 1);
              },
              child: const Icon(Icons.add, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}