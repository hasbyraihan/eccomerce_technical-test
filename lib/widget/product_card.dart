import 'package:flutter/material.dart';
import '../models/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 160, // ukuran card, bisa sesuaikan
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Produk
              ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                height: 120,
                width: double.infinity,
                // --- Ganti baris ini ---
                fit: BoxFit.contain, 
                // ---------------------
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    height: 120,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
              const SizedBox(height: 8),
              // Title
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),

              const SizedBox(height: 4),

              // Rating Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 2. Buat grup pertama (Rating) dengan Row baru
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating?.rate.toStringAsFixed(1) ?? "-",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),

                  // 3. Widget kedua adalah harga (tidak perlu dibungkus)
                  Text(
                    '\$ ${product.price ?? 0}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
