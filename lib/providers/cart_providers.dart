import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  static const String prefsKey = 'cart_items';

  CartNotifier() : super([]) {
    _loadFromPrefs();
  }

Future<void> _loadFromPrefs() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(prefsKey);
    if (jsonList != null) {
      final items = jsonList.map((e) {
        final Map<String, dynamic> jsonMap = jsonDecode(e);
        return CartItem.fromJson(jsonMap);
      }).toList();
      state = items;
    }
  } catch (e) {
  }
}


  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(prefsKey, jsonList);
  }

  void addItem(CartItem item) {
    final index = state.indexWhere((element) => element.title == item.title);
    if (index == -1) {
      state = [...state, item];
    } else {
      final oldItem = state[index];
      final updatedItem = oldItem.copyWith(quantity: oldItem.quantity + item.quantity);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedItem else state[i],
      ];
    }
    _saveToPrefs();
  }

  void removeItem(CartItem item) {
    state = state.where((element) => element != item).toList();
    _saveToPrefs();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    final index = state.indexWhere((element) => element.title == item.title);
    if (index != -1) {
      final updatedItem = state[index].copyWith(quantity: newQuantity);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedItem else state[i],
      ];
      _saveToPrefs();
    }
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.subtotal);
  }

  void clearCart() {
    state = [];
    _saveToPrefs();
  }
}
