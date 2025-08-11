import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product_providers.dart'; // pastikan path sesuai
import '../widget/banner_carousel.dart'; // widget ProductCard yang sudah dibuat
import '../widget/search_product.dart'; // widget ProductCard yang sudah dibuat
import '../widget/product_card.dart'; // widget ProductCard yang sudah dibuat

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      // bisa tambah appBar sesuai desain kalau mau
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchProduct(),
            const SizedBox(height: 20),
            const BannerCarousel(),

            const SizedBox(height: 20),

            // Widget untuk tampilkan produk dari API
            productsAsync.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Text('Produk kosong');
                }
                // Tampilkan list produk dalam Wrap supaya responsif
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: products.map((product) {
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
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
