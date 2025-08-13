import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../widget/add_to_cart.dart';
import '../providers/cart_providers.dart';
import '../models/cart_item.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  void _showAddToCartModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddToCartModal(
          product: widget.product,
          onAdd: (quantity) {
            final cartNotifier = ref.read(cartProvider.notifier);
            final newCartItem = CartItem(
              image: widget.product.image,
              title: widget.product.title,
              price: widget.product.price,
              quantity: quantity,
            );
            cartNotifier.addItem(newCartItem);
            Navigator.pop(context); // Tutup modal setelah add
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${widget.product.title} add $quantity pcs'),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      // Kita gunakan bottomNavigationBar untuk tombol sticky
      bottomNavigationBar: _buildStickyAddToCartButton(theme),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Gambar Produk ---
              Center(
                child: Hero(
                  tag: 'product_image_${widget.product.image}',
                  child: Image.network(
                    widget.product.image,
                    height: 280,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Title ---
              Text(
                widget.product.title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // --- Baris Harga dan Rating ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildRating(theme),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // --- Description ---
              Text(
                'Description',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 30,
              ), // Beri ruang ekstra di bawah sebelum tombol
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk Rating agar lebih rapi
  Widget _buildRating(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber.shade600, size: 20),
          const SizedBox(width: 6),
          Text(
            widget.product.rating?.rate.toStringAsFixed(1) ?? '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(
            '(${widget.product.rating?.count ?? 0} reviews)',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk Tombol Add to Cart
  Widget _buildStickyAddToCartButton(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 1.0)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: _showAddToCartModal,
          icon: const Icon(Icons.shopping_cart_checkout),
          label: const Text('Add to Cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
