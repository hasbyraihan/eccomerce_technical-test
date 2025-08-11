import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_item.dart';

class CartStorage {
  static const _cartKey = 'cart_items';

  // Simpan list cart ke SharedPreferences dalam bentuk JSON string
  Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_cartKey, jsonList);
  }

  // Load list cart dari SharedPreferences, kembalikan null jika tidak ada
  Future<List<CartItem>?> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_cartKey);

    if (jsonList == null) {
      return null;
    }

    try {
      final cartItems = jsonList
          .map((itemJson) => CartItem.fromJson(jsonDecode(itemJson)))
          .toList();
      return cartItems;
    } catch (e) {
      // Jika terjadi error parsing, hapus data corrupt dan return null
      await prefs.remove(_cartKey);
      return null;
    }
  }

  // Optional: hapus data cart dari SharedPreferences
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
