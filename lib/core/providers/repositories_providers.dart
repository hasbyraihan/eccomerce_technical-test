import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/product/data/repositories/product_repository.dart';

/// Provider untuk instance Dio (HTTP Client)
final dioProvider = Provider<Dio>((ref) => Dio());

/// Provider untuk ProductRepository, dengan injeksi Dio
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRepository(dio);
});
