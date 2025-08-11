import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/product_repository.dart';

// Provider untuk instance Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// Provider untuk ProductRepository, inject Dio ke repository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRepository(dio);
});
