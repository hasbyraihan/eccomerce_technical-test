import 'package:ecommerce_test/widget/profile_card.dart';
import 'package:ecommerce_test/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product_providers.dart';
import '../widget/banner_carousel.dart';
import '../widget/product_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchWidget(),
              const SizedBox(height: 20),
              const ProfileWidget(),
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
                    children:
                        products.map((product) {
                          return ProductCard(
                            product: product,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          ProductDetailScreen(product: product),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  );
                },
                loading:
                    () => Center(
                      child: Lottie.asset(
                        'assets/lottie/loading_new.json',
                        width: 200,
                        height: 200,
                      ),
                    ),
                error: (error, stack) => Text('Error: $error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
