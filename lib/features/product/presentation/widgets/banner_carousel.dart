import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  final List<String> images = const [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
    'assets/images/banner4.png',
    'assets/images/banner5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        aspectRatio: 16 / 9,
      ),
      items:
          images.map((imagePath) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
    );
  }
}
