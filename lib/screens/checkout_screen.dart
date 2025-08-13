import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_providers.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartProvider);

    // --- Bagian Kalkulasi Harga ---
    final subtotal = cartItems.fold<double>(
      0,
      (prev, item) => prev + item.price * item.quantity,
    );
    const shippingFee = 5.0; // Dummy ongkos kirim
    final total = subtotal + shippingFee;
    // ----------------------------

    // --- Penanganan Keranjang Kosong ---
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: const Center(
          child: Text(
            "Keranjang Anda kosong!",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }
    // ---------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[100],
      // Tombol "Pay Now" yang selalu menempel di bawah
      bottomNavigationBar: _buildPayNowButton(theme, total),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Bagian Alamat Pengiriman ---
            _buildSectionHeader("Delivery Location"),
            _buildInfoCard(
              icon: Icons.location_on_outlined,
              title: "Home",
              subtitle: "St. Greenvillage Alabama",
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // --- Bagian Ringkasan Pesanan ---
            _buildSectionHeader("Order"),
            _buildOrderSummaryCard(cartItems, theme),
            const SizedBox(height: 16),

            // --- Bagian Metode Pembayaran ---
            _buildSectionHeader("Payment"),
            _buildInfoCard(
              icon: Icons.payment_outlined,
              title: "Seabank",
              subtitle: "Current Balance: \$299,53",
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // --- Bagian Rincian Harga ---
            _buildSectionHeader("Detail Payment"),
            _buildPriceDetailsCard(subtotal, shippingFee, total, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildOrderSummaryCard(List<dynamic> cartItems, ThemeData theme) {
    return Card(
      elevation: 1,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Qty: ${item.quantity}'),
            trailing: Text(
              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceDetailsCard(
    double subtotal,
    double shippingFee,
    double total,
    ThemeData theme,
  ) {
    return Card(
      elevation: 1,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _priceRow("Subtotal", '\$${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            _priceRow("Ongkos Kirim", '\$${shippingFee.toStringAsFixed(2)}'),
            const Divider(height: 24),
            _priceRow(
              "Total",
              '\$${total.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {TextStyle? style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: style ?? const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildPayNowButton(ThemeData theme, double total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            /* Logika pembayaran */
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text('Pay Now (\$${total.toStringAsFixed(2)})'),
        ),
      ),
    );
  }
}
