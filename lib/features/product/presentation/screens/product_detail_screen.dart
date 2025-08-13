import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product.dart';
import '../widgets/product_image.dart';
import '../widgets/product_price_rating.dart';
import '../widgets/product_description.dart';
import '../widgets/add_to_cart_button.dart';
import '../../../cart/providers/cart_providers.dart';
import '../../../cart/data/models/cart_item.dart';
import '../widgets/add_to_cart.dart';

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
      builder: (_) {
        return AddToCartModal(
          product: widget.product,
          onAdd: (quantity) {
            final cartNotifier = ref.read(cartProvider.notifier);
            cartNotifier.addItem(
              CartItem(
                image: widget.product.image,
                title: widget.product.title,
                price: widget.product.price,
                quantity: quantity,
              ),
            );
            Navigator.pop(context);
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
      bottomNavigationBar: AddToCartButton(
        onPressed: _showAddToCartModal,
        theme: theme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(imageUrl: widget.product.image),
            const SizedBox(height: 24),
            Text(
              widget.product.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ProductPriceRating(product: widget.product),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ProductDescription(description: widget.product.description),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
