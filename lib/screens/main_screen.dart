import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

// State provider untuk bottom nav index
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final pages = const [
      HomeScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
      // --- Properti untuk tampilan modern ---
      type: BottomNavigationBarType.fixed, // Wajib agar background color & style bekerja
      backgroundColor: Colors.white,      // Latar belakang putih bersih
      selectedItemColor: Colors.orange,   // Warna item yang aktif
      unselectedItemColor: Colors.grey,   // Warna item yang tidak aktif
      showSelectedLabels: true,           // Tampilkan label pada item aktif
      showUnselectedLabels: false,        // Sembunyikan label pada item tidak aktif
      elevation: 8.0,                     // Beri sedikit bayangan
      // ------------------------------------

      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), // Gunakan ikon 'outlined'
          activeIcon: Icon(Icons.home),     // Ikon 'filled' saat aktif
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    ),
    );
  }
}
