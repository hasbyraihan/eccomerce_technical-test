import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Search Field
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.orange),
            ),
            child: const TextField(
              style: TextStyle(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Search Product",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ), // Gaya untuk hint
                prefixIcon: Icon(Icons.search, color: Colors.orange),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Ikon Aksi
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.confirmation_number_outlined,
            color: theme.primaryColor,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chat_bubble_outline,
            color: theme.primaryColor,
            size: 28,
          ),
        ),
      ],
    );
  }
}
