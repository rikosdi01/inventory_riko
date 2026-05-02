import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/arsip/testing/editinputpage.dart';
import 'package:rikoparts/arsip/testing/inputpage2.dart';
import 'package:rikoparts/arsip/testing/provider.dart';

class OutputPage extends StatefulWidget {
  const OutputPage({super.key});

  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TestingProvider>(context);
    final inputlist = prov.inputan;
    return Scaffold(
      appBar: AppBar(title: Text('Output Page')),
      body: ListView.builder(
        itemCount: inputlist.length,
        itemBuilder: (context, index) {
          final input = inputlist[index];
          return ListTile(
            title: Text('Item: ${input.item}'),
            subtitle: Text('Quantity: ${input.qty.toString()}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditInputPage(index: index),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputPage()),
          );

          if (result != null) {
            // Get the data from the result and add it to gudangprovider
            var prov = Provider.of<TestingProvider>(context, listen: false);
            prov.addInput(result['item'], result['qty']);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
