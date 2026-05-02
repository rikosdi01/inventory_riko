import 'package:flutter/material.dart';

class MyInputPage extends StatefulWidget {
  const MyInputPage({super.key});

  @override
  State<MyInputPage> createState() => _MyInputPageState();
}

class _MyInputPageState extends State<MyInputPage> {
  final List<TextEditingController> itemControllers = [];
  final List<TextEditingController> qtyControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing"),
      ),
      body: Column(
        children: [
          Column(
            children: List.generate(3, (index) {
              final itemController = itemControllers.length > index
                  ? itemControllers[index]
                  : TextEditingController();
              if (itemControllers.length <= index) {
                itemControllers.add(itemController);
              }

              final qtyController = qtyControllers.length > index
                  ? qtyControllers[index]
                  : TextEditingController();
              if (qtyControllers.length <= index) {
                qtyControllers.add(qtyController);
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextField(
                        controller: itemController,
                        decoration: InputDecoration(labelText: 'Item'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: TextField(
                        controller: qtyController,
                        decoration: InputDecoration(labelText: 'Qty'),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                List<String> selectedItem = [];
                List<int> selectedQty = [];

                for (int i = 0; i < itemControllers.length; i++) {
                  String item = itemControllers[i].text;
                  int qty = int.tryParse(qtyControllers[i].text) ?? 0;

                  selectedItem.add(item);
                  selectedQty.add(qty);
                }

                Navigator.pop(
                  context,
                  {
                    'item': selectedItem,
                    'qty': selectedQty,
                  },
                );
              },
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}
