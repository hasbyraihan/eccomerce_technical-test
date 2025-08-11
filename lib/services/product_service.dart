import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com', // contoh API
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      final List data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat produk: $e');
    }
  }
}
