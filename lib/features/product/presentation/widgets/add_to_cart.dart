import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class AddToCartModal extends StatefulWidget {
  final Product product;
  final void Function(int quantity) onAdd;

  const AddToCartModal({super.key, required this.product, required this.onAdd});

  @override
  State<AddToCartModal> createState() => _AddToCartModalState();
}

class _AddToCartModalState extends State<AddToCartModal> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalPrice = widget.product.price * count;

    return Padding(
      
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Handle Penarik (Grab Handle)
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Info Produk
            _buildProductInfo(theme),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // 3. Kontrol Kuantitas (Stepper)
            _buildQuantityControl(theme),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // 4. Tampilan Total Harga
            _buildTotalPrice(theme, totalPrice),
            const SizedBox(height: 24),

            // 5. Tombol Aksi Utama
            _buildActionButton(context, theme),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk Info Produk
  Widget _buildProductInfo(ThemeData theme) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.product.image,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
            errorBuilder:
                (_, __, ___) => const Icon(Icons.broken_image, size: 80),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget untuk Kontrol Kuantitas
  Widget _buildQuantityControl(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Quantity", style: theme.textTheme.titleMedium),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.grey),
                onPressed: () {
                  if (count > 1) {
                    setState(() => count--);
                  }
                },
              ),
              Text(
                count.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: theme.primaryColor),
                onPressed: () {
                  setState(() => count++);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget untuk Total Harga
  Widget _buildTotalPrice(ThemeData theme, double totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total Price", style: theme.textTheme.titleMedium),
        Text(
          '\$${totalPrice.toStringAsFixed(2)}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }

  // Helper widget untuk Tombol Aksi
  Widget _buildActionButton(BuildContext context, ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          widget.onAdd(count);
          // Navigator.pop(context) sudah dipanggil di parent,
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Add Now'),
      ),
    );
  }
}
