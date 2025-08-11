import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Definisi Warna untuk kemudahan kustomisasi
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color textColor = Colors.grey.shade800;
    final Color subtextColor = Colors.grey.shade600;
    final Color backgroundColor = Colors.grey.shade100;
    final Color cardColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Profil Saya',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: cardColor,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Bagian Header Profil ---
              _buildProfileHeader(textColor, subtextColor),
              const SizedBox(height: 24),

              // --- Bagian Statistik Pengguna ---
              _buildStatsCounter(primaryColor, textColor, subtextColor),
              const SizedBox(height: 20),

              // --- Bagian Menu Opsi ---
              _buildOptionMenu(cardColor, textColor),
              const SizedBox(height: 20),
              
              // --- Tombol Logout ---
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk Header Profil
  Widget _buildProfileHeader(Color textColor, Color subtextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'), // Gambar dummy
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gemini AI',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'gemini.ai@example.com',
                style: TextStyle(
                  fontSize: 14,
                  color: subtextColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_outlined, color: subtextColor),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Statistik
  Widget _buildStatsCounter(Color primaryColor, Color textColor, Color subtextColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('12', 'Pesanan', primaryColor, textColor, subtextColor),
          _buildStatItem('8', 'Wishlist', primaryColor, textColor, subtextColor),
          _buildStatItem('5', 'Voucher', primaryColor, textColor, subtextColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color primaryColor, Color textColor, Color subtextColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: subtextColor,
          ),
        ),
      ],
    );
  }

  // Widget Helper untuk Menu Opsi
  Widget _buildOptionMenu(Color cardColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildListTile(Icons.person_outline, 'Akun Saya', textColor, () {}),
            _buildListTile(Icons.location_on_outlined, 'Alamat Pengiriman', textColor, () {}),
            _buildListTile(Icons.payment_outlined, 'Metode Pembayaran', textColor, () {}),
            _buildListTile(Icons.notifications_none_outlined, 'Notifikasi', textColor, () {}),
            _buildListTile(Icons.security_outlined, 'Keamanan Akun', textColor, () {}),
            _buildListTile(Icons.help_outline, 'Pusat Bantuan', textColor, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, Color textColor, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade500),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
  
  // Widget Helper untuk Tombol Logout
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Keluar'),
          onPressed: () {
            // Logika untuk logout
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}