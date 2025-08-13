import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_counter.dart';
import '../widgets/option_menu.dart';
import '../widgets/logout_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade200,
              Colors.orange.shade100,
              Colors.white,
            ],
          ),
        ),
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                ProfileHeader(),
                SizedBox(height: 24),
                StatsCounter(),
                SizedBox(height: 20),
                OptionMenu(),
                SizedBox(height: 20),
                LogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
