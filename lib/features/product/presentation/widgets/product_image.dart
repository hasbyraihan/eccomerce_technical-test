import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'product_image_$imageUrl',
        child: Image.network(
          imageUrl,
          height: 280,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 100),
        ),
      ),
    );
  }
}
