import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/arsip/testing2/input.dart';
import 'package:rikoparts/arsip/testing2/provider.dart';

class MyOutputPage extends StatefulWidget {
  const MyOutputPage({super.key});

  @override
  State<MyOutputPage> createState() => _MyOutputPageState();
}

class _MyOutputPageState extends State<MyOutputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Output Page"),
      ),
      body: Text("OK"),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyInputPage()),
          );

          if (result != null) {
            // Get the data from the result and add it to gudangprovider
            var prov = Provider.of<GudangItem>(context, listen: false);
            prov.addItem(result['item'], result['qty']);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}