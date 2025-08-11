import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    // Cek apakah item sudah ada (by title misal)
    final index = state.indexWhere((element) => element.title == item.title);
    if (index == -1) {
      state = [...state, item];
    } else {
      // update quantity jika sudah ada
      final oldItem = state[index];
      final updatedItem = oldItem.copyWith(quantity: oldItem.quantity + item.quantity);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedItem else state[i],
      ];
    }
  }

  void removeItem(CartItem item) {
    state = state.where((element) => element != item).toList();
  }

void updateQuantity(CartItem item, int newQuantity) {
  final index = state.indexWhere((element) => element.title == item.title);
  if (index != -1) {
    final updatedItem = state[index].copyWith(quantity: newQuantity);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedItem else state[i],
    ];
  }
}

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.subtotal);
  }

  void clearCart() {
    state = [];
  }
}
