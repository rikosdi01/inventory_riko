import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/widgets/listviewrakdepotinfo.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class RakDepotInfo extends StatefulWidget {
  const RakDepotInfo({super.key});

  @override
  State<RakDepotInfo> createState() => _RakDepotInfoState();
}

class _RakDepotInfoState extends State<RakDepotInfo> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var rakDepotController = TextEditingController();
    var alamatDepotController = TextEditingController();
    var itemindepot = prov.items;

    return Scaffold(
      appBar: AppBar(title: const Text("Rak Depot Info"), actions: [
        if (itemindepot.any((item) =>
            item.rak?.any((gudangItem) =>
                gudangItem.rak == "Depot" && gudangItem.qty > 0) ??
            false))
          TextButton(
            onPressed: () {},
            child: const Text(
              "Stok Masuk",
              style: TextStyle(color: Colors.white),
            ),
          ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tambah Rak'),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            TextField(
                              controller: rakDepotController,
                              decoration:
                                  const InputDecoration(labelText: "Nama Rak"),
                            ),
                            TextField(
                              controller: alamatDepotController,
                              decoration: const InputDecoration(
                                  labelText: "Alamat Rak"),
                            ),
                            const SizedBox(
                              height: 20,
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
                                    prov.addRakDepot(rakDepotController.text,
                                        alamatDepotController.text);
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
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Tambah Rak",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ]),
      body: const ListViewRakDepotInfo(),
    );
  }
}
