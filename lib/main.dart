import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/providers/shared_preferences_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/main/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Wajib sebelum async init

  final sharedPrefs = await SharedPreferences.getInstance(); // Load local storage

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs), // Inject ke Riverpod
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Tema global
      initialRoute: '/', // Halaman awal
      routes: {
        '/': (_) => const SplashScreen(),
        '/home': (_) => const MainScreen(),
      },
    );
  }
}
