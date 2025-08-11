import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import 'checkout_screen.dart';
import '../widget/add_to_cart.dart';
import '../providers/cart_providers.dart';
import '../models/cart_item.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  void _showAddToCartModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddToCartModal(
          product: widget.product,
          onAdd: (quantity) {
            // Panggil method dari cartProvider untuk add item
            final cartNotifier = ref.read(cartProvider.notifier);

            final newCartItem = CartItem(
              image: widget.product.image,
              title: widget.product.title,
              price: widget.product.price,
              quantity: quantity,
            );

            cartNotifier.addItem(newCartItem);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${widget.product.title} ditambahkan sebanyak $quantity')),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Center(
              child: Image.network(
                widget.product.image,
                height: 250,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Price
            Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 6),
                Text(
                  widget.product.rating?.rate.toStringAsFixed(1) ?? '-',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${widget.product.rating?.count ?? 0})',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Tombol Add to Cart
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showAddToCartModal,
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
