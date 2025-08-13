import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import 'package:lottie/lottie.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product_image_${product.image}',
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) => const Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: Lottie.asset(
                        'assets/lottie/loading_new.json',
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
            ),

            // --- Bagian Info di bawah gambar ---
            Container(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Baris Harga dan Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Harga
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.rating?.rate.toStringAsFixed(1) ?? '-',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
