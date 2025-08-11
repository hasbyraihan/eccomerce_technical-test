import 'package:flutter/material.dart';
import '../models/product.dart';

class AddToCartModal extends StatefulWidget {
  final Product product;
  final void Function(int quantity) onAdd;

  const AddToCartModal({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  State<AddToCartModal> createState() => _AddToCartModalState();
}

class _AddToCartModalState extends State<AddToCartModal> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            Text(
              'Pilih jumlah',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (count > 1) {
                      setState(() {
                        count--;
                      });
                    }
                  },
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAdd(count);
                  Navigator.pop(context);
                },
                child: const Text('Add Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
