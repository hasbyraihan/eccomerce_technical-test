import 'package:flutter/material.dart';

// Enum untuk menentukan jenis dialog yang akan ditampilkan
enum DialogType { success, failed, confirmation }

// Mengembalikan `true` jika tombol konfirmasi ditekan, `false` untuk batal, `null` jika ditutup.
Future<bool?> showAppDialog({
  required BuildContext context,
  required DialogType type,
  required String title,
  required String message,
  String confirmButtonText = "Yes",
  String cancelButtonText = "No",
}) {
  IconData icon;
  Color iconColor;

  // Tentukan ikon dan warna berdasarkan tipe dialog
  switch (type) {
    case DialogType.success:
      icon = Icons.check_circle;
      iconColor = Colors.green;
      confirmButtonText = "OK";
      break;
    case DialogType.failed:
      icon = Icons.cancel;
      iconColor = Colors.red;
      confirmButtonText = "Try Again";
      break;
    case DialogType.confirmation:
      icon = Icons.help;
      iconColor = Colors.orange;
      break;
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // Pengguna harus menekan tombol
    builder: (BuildContext context) {
      return _AppDialogContent(
        title: title,
        message: message,
        icon: icon,
        iconColor: iconColor,
        // Tampilkan dua tombol jika tipenya confirmation
        actions:
            (type == DialogType.confirmation)
                ? [
                  TextButton(
                    child: Text(cancelButtonText),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pop(false), // Kembali dengan nilai false
                  ),
                  ElevatedButton(
                    child: Text(confirmButtonText),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pop(true), // Kembali dengan nilai true
                  ),
                ]
                : [
                  ElevatedButton(
                    child: Text(confirmButtonText),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pop(true), // Kembali dengan nilai true
                  ),
                ],
      );
    },
  );
}

class _AppDialogContent extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final List<Widget> actions;

  const _AppDialogContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none, // Izinkan ikon keluar dari batas Dialog
        children: [
          // Konten utama dialog
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions,
                ),
              ],
            ),
          ),
          // Ikon yang "melayang" di atas
          Positioned(
            top: -40,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[100],
              child: Icon(icon, color: iconColor, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
