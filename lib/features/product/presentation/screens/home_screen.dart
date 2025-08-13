import 'package:ecommerce_test/features/product/presentation/widgets/profile_card.dart';
import 'package:ecommerce_test/features/product/presentation/widgets/search.dart';
import 'package:ecommerce_test/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/product_providers.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/product_list.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return SafeArea(
      child: Scaffold(
        // Wrap SingleChildScrollView dengan RefreshIndicator
        body: RefreshIndicator(
          onRefresh: () async {
            // Refresh provider untuk fetch ulang data
            ref.refresh(productsProvider);
            // Tunggu sebentar supaya loading indicator terlihat
            await Future.delayed(const Duration(milliseconds: 300));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // penting supaya bisa scroll saat konten kurang
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
                productsAsync.when(
                  data: (products) => ProductList(products: products),
                  loading: () => const LoadingIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}