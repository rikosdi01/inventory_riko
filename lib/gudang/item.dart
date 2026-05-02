import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/tambahitem.dart';
import 'package:rikoparts/gudang/widgets/cardview.dart';
import 'package:rikoparts/gudang/widgets/drawer.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class MyItemPage extends StatefulWidget {
  const MyItemPage({super.key});

  @override
  State<MyItemPage> createState() => _MyItemPageState();
}

class _MyItemPageState extends State<MyItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Gudang"),
      ),
      drawer: const MyDrawer(),
      body: const MyCardView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahItemPage()),
          );

          if (result != null) {
            // Get the data from the result and add it to gudangprovider
            var prov = Provider.of<Gudangprovider>(context, listen: false);
            prov.addItems(result['kode'], result['item'], result['satuan'],
                result['isi'], result['harga'], result['image']);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
