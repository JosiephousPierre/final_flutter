import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/inventory_provider.dart';
import '../widgets/inventory_list.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Tracker',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD3D3D3), // Light Grey Text
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF25274D),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFAAABB8), // Updated Background Color
              child: const InventoryList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color(0xFF25274D),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Item Name',
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), // Light Grey Text
                          ),
                          filled: true,
                          fillColor: const Color(0xFFAAABB8), // Updated Fill Color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), // Light Grey Text
                          ),
                          filled: true,
                          fillColor: const Color(0xFFAAABB8), // Updated Fill Color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final quantity =
                        int.tryParse(quantityController.text) ?? 0;

                    if (name.isNotEmpty && quantity > 0) {
                      ref.read(inventoryProvider).addItem(name, quantity);
                      nameController.clear();
                      quantityController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF29648A),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add Item',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text remains black for better contrast
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
