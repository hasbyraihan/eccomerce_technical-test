import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Pindah ke halaman berikut setelah 5 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // 1. Tambahkan Container sebagai pembungkus utama
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            // 2. Definisikan LinearGradient dengan 3 warna
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade200, // Warna oranye paling atas
                Colors.orange.shade50,  // Warna oranye pudar di tengah
                Colors.white,           // Warna putih paling bawah
              ],
            ),
          ),
        child: Center(
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
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
