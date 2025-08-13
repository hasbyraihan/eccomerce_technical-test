import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class ProductPriceRating extends StatelessWidget {
  final Product product;

  const ProductPriceRating({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
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
                product.rating?.rate.toStringAsFixed(1) ?? '-',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '(${product.rating?.count ?? 0} reviews)',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
