import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import 'repositories_providers.dart';

// FutureProvider yang akan fetch list produk menggunakan repository
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});
