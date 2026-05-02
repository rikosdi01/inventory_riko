import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/tambahpersamaan.dart';
import 'package:rikoparts/gudang/widgets/cardviewpersamaan.dart';
import 'package:rikoparts/gudang/widgets/drawer.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class PersamaanPage extends StatefulWidget {
  const PersamaanPage({super.key});

  @override
  State<PersamaanPage> createState() => _PersamaanPageState();
}

class _PersamaanPageState extends State<PersamaanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Persamaan"),
      ),
      drawer: const MyDrawer(),
      body: const MyCardViewPersamaan(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahPersamaan()),
          );

          if (result != null) {
            // Get the data from the result and add it to gudangprovider
            var prov = Provider.of<Gudangprovider>(context, listen: false);
            prov.addPersamaanItem(
                result['kategori'], result['item'], result['keterangan']);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
