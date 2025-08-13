import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_providers.dart';
import '../../../../shared/widgets/app_dialog.dart';

class PayNowButton extends ConsumerWidget {
  final double total;
  final ThemeData theme;

  const PayNowButton({super.key, required this.total, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          // 3. Perbarui logika onPressed
          onPressed: () async {
            // Tampilkan dialog konfirmasi terlebih dahulu
            final confirmed = await showAppDialog(
              context: context,
              type: DialogType.confirmation,
              title: "Confirmation Payment",
              message:
                  "You will pay \$${total.toStringAsFixed(2)}. Continue Payment?",
              confirmButtonText: "Pay now",
            );

            // Jika pengguna menekan "Ya"
            if (confirmed == true) {
              // Hapus semua item di keranjang
              ref.read(cartProvider.notifier).clearCart();

              // Tampilkan dialog sukses
              if (context.mounted) {
                await showAppDialog(
                  context: context,
                  type: DialogType.success,
                  title: "Payment Success!",
                  message: "Your item is on the way.",
                  confirmButtonText: "Okay",
                );
              }

              // Opsional: Arahkan pengguna kembali ke halaman utama
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }
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
