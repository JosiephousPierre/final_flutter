import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/inventory_provider.dart';

class InventoryList extends ConsumerWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(inventoryProvider).items;

    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No items in inventory. Add some!',
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 118, 118, 118)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text(
                item.quantity.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            title: Text(
              item.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Quantity: ${item.quantity}',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.teal),
                  onPressed: () {
                    final controller =
                        TextEditingController(text: item.quantity.toString());
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Update Quantity'),
                        content: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'New Quantity',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              final newQuantity =
                                  int.tryParse(controller.text) ?? 0;
                              if (newQuantity > 0) {
                                ref
                                    .read(inventoryProvider)
                                    .updateQuantity(item.id, newQuantity);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ref.read(inventoryProvider).removeItem(item.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
