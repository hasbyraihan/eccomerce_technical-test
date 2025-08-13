import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/presentation/screens/home_screen.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/bottom_navbar.dart';

/// Provider untuk menyimpan state index BottomNavigationBar
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// MainScreen adalah halaman utama dengan navigasi bottom bar
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    // Daftar halaman sesuai tab
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
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
