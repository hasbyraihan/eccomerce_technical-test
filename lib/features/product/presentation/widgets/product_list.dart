import 'package:flutter/material.dart';
import '../../data/models/product.dart'; // Pastikan path model benar
import '../screens/product_detail_screen.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  // Perbaikan Tipe Data: Jadikan lebih spesifik
  final List<Product> products;

  const ProductList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      // Tampilan jika produk kosong bisa dibuat lebih baik
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('Produk tidak ditemukan.'),
        ),
      );
    }

    // Gunakan GridView.builder untuk performa terbaik
    return GridView.builder(
      // Fix untuk layout di dalam SingleChildScrollView
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      
      padding: const EdgeInsets.only(top: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }
}