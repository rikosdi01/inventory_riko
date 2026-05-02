import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class EditInputPage extends StatefulWidget {
  final int index;

  EditInputPage({required this.index});

  @override
  _EditInputPageState createState() => _EditInputPageState();
}

class _EditInputPageState extends State<EditInputPage> {
  late TextEditingController _itemController;
  late TextEditingController _qtyController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TestingProvider>(context, listen: false);
    final input = provider.getInputAt(widget.index);

    _itemController = TextEditingController(text: input.item);
    _qtyController = TextEditingController(text: input.qty.toString());
  }

  @override
  void dispose() {
    _itemController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
            TextField(
              controller: _qtyController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final item = _itemController.text;
                final qty = int.tryParse(_qtyController.text) ?? 0;

                if (item.isNotEmpty && qty > 0) {
                  final provider = Provider.of<TestingProvider>(context, listen: false);
                  final updatedInput = Input(item: item, qty: qty);
                  provider.updateInput(widget.index, updatedInput);

                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
