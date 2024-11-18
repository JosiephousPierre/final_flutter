import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/inventory_item.dart';

class InventoryNotifier extends ChangeNotifier {
  final List<InventoryItem> _items = [];

  List<InventoryItem> get items => List.unmodifiable(_items);

  void addItem(String name, int quantity) {
    _items.add(InventoryItem(
      id: DateTime.now().toString(),
      name: name,
      quantity: quantity,
    ));
    notifyListeners();
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

final inventoryProvider = ChangeNotifierProvider<InventoryNotifier>((ref) {
  return InventoryNotifier();
});
