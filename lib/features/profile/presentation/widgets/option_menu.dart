import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _buildListTile(Icons.person_outline, 'My Profile', () {}),
            _buildListTile(Icons.location_on_outlined, 'Location Delivery', () {}),
            _buildListTile(Icons.payment_outlined, 'Payment', () {}),
            _buildListTile(Icons.notifications_none_outlined, 'Notification', () {}),
            _buildListTile(Icons.security_outlined, 'Security Account', () {}),
            _buildListTile(Icons.help_outline, 'FAQ', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade500),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}