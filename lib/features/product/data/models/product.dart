import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// Helper untuk konversi numerik ke `double`.
double _toDouble(dynamic v) => v is int ? v.toDouble() : (v as num).toDouble();

/// Model rating produk.
@freezed
class Rating with _$Rating {
  const factory Rating({
    @JsonKey(fromJson: _toDouble) required double rate,
    required int count,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}

/// Model produk dengan informasi harga, kategori, dan rating.
@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required String description,
    @JsonKey(fromJson: _toDouble) required double price,
    required String image,
    String? category,
    Rating? rating,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
