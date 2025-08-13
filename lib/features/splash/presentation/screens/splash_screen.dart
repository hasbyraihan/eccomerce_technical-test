import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

/// SplashScreen
/// Menampilkan animasi pembuka aplikasi selama 5 detik
/// sebelum diarahkan ke halaman utama (`/home`).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigasi otomatis ke halaman utama setelah 5 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Background gradient oranye → putih
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade200,
              Colors.orange.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Konten tengah: animasi Lottie + teks
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/lottie/splash.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'AntiMarket',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Logo di bagian bawah layar
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/antikode.png',
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
