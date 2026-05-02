import 'package:flutter/material.dart';

class Item {
  List<String> item;
  List<int> qty;

  Item({required this.item, required this.qty});
}

class GudangItem extends ChangeNotifier {
  final List<Item> _item = [];

  addItem(List<String> item, List<int> qty) {
    _item.add(Item(item: item, qty: qty));
    notifyListeners();

    print(item);
    print(qty);
  }
}
