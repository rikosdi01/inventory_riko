import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/widgets/listviewrakF7info.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class RakF7Info extends StatefulWidget {
  const RakF7Info({super.key});

  @override
  State<RakF7Info> createState() => _RakF7InfoState();
}

class _RakF7InfoState extends State<RakF7Info> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var rakF7Controller = TextEditingController();
    var alamatF7Controller = TextEditingController();
    var iteminF7 = prov.items;

    return Scaffold(
      appBar: AppBar(title: const Text("Rak F7 Info"), actions: [
        if (iteminF7.any((item) =>
            item.rak?.any(
                (gudangItem) => gudangItem.rak == "F7" && gudangItem.qty > 0) ??
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
                              controller: rakF7Controller,
                              decoration:
                                  const InputDecoration(labelText: "Nama Rak"),
                            ),
                            TextField(
                              controller: alamatF7Controller,
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
                                    prov.addRakF7(rakF7Controller.text,
                                        alamatF7Controller.text);
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
      body: const ListViewRakF7Info(),
    );
  }
}
