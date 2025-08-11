import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

// Helper konversi int ke double (jika perlu)
double _toDouble(dynamic v) => v is int ? v.toDouble() : (v as num).toDouble();

@freezed
class Rating with _$Rating {
  const factory Rating({
    @JsonKey(fromJson: _toDouble) required double rate,
    required int count,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required String description,
    @JsonKey(fromJson: _toDouble) required double price,
    required String image,
    String? category,
    Rating? rating,  // Field rating optional sesuai API
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
