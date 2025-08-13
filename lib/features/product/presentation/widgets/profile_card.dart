import 'package:flutter/material.dart';
import 'dart:ui'; // Diperlukan untuk BackdropFilter

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade100,
            Colors.orange.shade100,
            Colors.orange.shade50,
            Colors.orange.shade50,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      child: Row(
        children: [
          // Foto Profil
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=a042581f4e29026704d',
            ),
          ),
          const SizedBox(width: 16),
          // Info Pengguna
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Hasby Raihan",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Info Saldo (Glassmorphism)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade500),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: theme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "\$1,250.00",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
