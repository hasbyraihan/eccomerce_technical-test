import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_providers.dart';
import '../widgets/section_header.dart';
import '../widgets/info_card.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/price_details_card.dart';
import '../widgets/pay_now_button.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartProvider);

    final subtotal = cartItems.fold<double>(
      0,
      (prev, item) => prev + item.price * item.quantity,
    );
    const shippingFee = 5.0;
    final total = subtotal + shippingFee;

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: const Center(
          child: Text(
            "Your Cart is Empty!",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: PayNowButton(total: total, theme: theme),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: "Delivery Location"),
            InfoCard(
              icon: Icons.location_on_outlined,
              title: "My Home",
              subtitle: "St. Greenvillage Alabama",
              onTap: () {},
            ),
            const SizedBox(height: 16),

            const SectionHeader(title: "Detail Order"),
            OrderSummaryCard(cartItems: cartItems),
            const SizedBox(height: 16),

            const SectionHeader(title: "Payment"),
            InfoCard(
              icon: Icons.payment_outlined,
              title: "Seabank",
              subtitle: "Current Balance: \$299,53",
              onTap: () {},
            ),
            const SizedBox(height: 16),

            const SectionHeader(title: "Detail Payment"),
            PriceDetailsCard(
              subtotal: subtotal,
              shippingFee: shippingFee,
              total: total,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }
}
