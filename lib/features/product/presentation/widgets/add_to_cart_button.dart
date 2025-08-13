import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ThemeData theme;

  const AddToCartButton({
    super.key,
    required this.onPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.shopping_cart_checkout),
          label: const Text('Add to Cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
