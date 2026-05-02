import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/rakdepotinfo.dart';
import 'package:rikoparts/gudang/rakf7info.dart';
import 'package:rikoparts/gudang/rakgudanginfo.dart';
import 'package:rikoparts/gudang/widgets/drawer.dart';
import 'package:rikoparts/gudang/widgets/listviewgudang.dart';
import 'package:rikoparts/penerimaan/prosespenerimaan.dart';

import '../provider/gudangprovider.dart';

class GudangPage extends StatefulWidget {
  const GudangPage({super.key});

  @override
  State<GudangPage> createState() => _GudangPageState();
}

class _GudangPageState extends State<GudangPage> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var rakController = TextEditingController();
    var iteminMasukBarang = prov.items;
    return Scaffold(
      appBar: AppBar(title: const Text("Gudang"), actions: [
        if (iteminMasukBarang.any((item) =>
            item.rak?.any((gudangItem) =>
                gudangItem.rak == "Masuk Barang" && gudangItem.qty > 0) ??
            false))
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProsesPenerimaanPage()));
            },
            child: const Text(
              "Stok Masuk Barang",
              style: TextStyle(color: Colors.white),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
            onPressed: () {
              if (prov.items.isEmpty) {
                showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                          title: Text("Input item dulu"),
                        ));
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text('Tambah Rak'),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    content: SizedBox(
                      height: 180,
                      child: Column(
                        children: [
                          TextField(
                            controller: rakController,
                            decoration:
                                const InputDecoration(labelText: "Nama Rak"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const RakGudangInfo()));
                              },
                              child: const Text("Rak Gudang Info"),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const RakDepotInfo()));
                              },
                              child: const Text("Rak Depot Info"),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const RakF7Info()));
                              },
                              child: const Text("Rak F7 Info"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Colors.blue),
                              child: TextButton(
                                onPressed: () {
                                  prov.addGudang(rakController.text);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
            child: const Text(
              "Tambah Rak",
              style: TextStyle(color: Colors.white),
            ))
      ]),
      drawer: const MyDrawer(),
      body: const ListViewGudang(),
    );
  }
}
