import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const CartItem._(); // constructor private supaya bisa pakai getter

  const factory CartItem({
    required String image,
    required String title,
    required double price,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  // Getter subtotal (price * quantity)
  double get subtotal => price * quantity;
}
