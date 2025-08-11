// lib/repositories/product_repository.dart
import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<List<Product>> getProducts() async {
    final response = await _dio.get('https://fakestoreapi.com/products');
    final List data = response.data;
    return data.map((e) => Product.fromJson(e)).toList();
  }
}