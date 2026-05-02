import 'package:flutter/material.dart';

class Input {
  String item;
  int qty;

  Input({required this.item, required this.qty});
}

class Output {
  String item;
  int qty;

  Output({required this.item, required this.qty});
}

class TestingProvider extends ChangeNotifier {
  final List<Input> _inputan = [];

  addInput(String item, int qty) {
    _inputan.add(Input(item: item, qty: qty));
    notifyListeners();
  }

  updateInput(int index, Input updatedInput) {
    _inputan[index] = updatedInput;
    notifyListeners();
  }

  Input getInputAt(int index) {
    return _inputan[index];
  }

  List<Input> get inputan => _inputan.toList();
}
