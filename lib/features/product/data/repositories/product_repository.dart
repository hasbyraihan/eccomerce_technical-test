import 'package:dio/dio.dart';
import '../models/product.dart';

/// Repository untuk mengambil data produk dari API
class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  /// Mengambil daftar produk dari API
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      final List data = response.data;
      return data.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      // Tangani error dari request
      throw Exception('Gagal memuat produk: ${e.message}');
    }
  }
}
