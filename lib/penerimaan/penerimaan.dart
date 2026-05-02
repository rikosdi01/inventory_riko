import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/widgets/drawer.dart';
import 'package:rikoparts/penerimaan/inputpenerimaan.dart';
import 'package:rikoparts/penerimaan/prosespenerimaan.dart';
import 'package:rikoparts/penerimaan/widgets/listviewpenerimaan.dart';
import 'package:rikoparts/provider/gudangprovider.dart';
import 'package:rikoparts/provider/penerimaanprovider.dart';

class PenerimaanPage extends StatefulWidget {
  const PenerimaanPage({super.key});

  @override
  State<PenerimaanPage> createState() => _PenerimaanPageState();
}

class _PenerimaanPageState extends State<PenerimaanPage> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<PenerimaanProvider>(context);
    var vendorController = TextEditingController();
    var alamatVendorController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penerimaan"),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProsesPenerimaanPage()),
                    );

                    if (result != null) {
                      // Get the data from the result and add it to gudangprovider

                      var prov = Provider.of<PenerimaanProvider>(context,
                          listen: false);
                      prov.addPenerimaan(
                        result['vendor'],
                        result['pesanan'],
                        result['kode'],
                        result['tanggal'],
                        result['rak'],
                        result['item'],
                        result['qty'],
                        result['deskripsi'],
                      );

                      var prov2 =
                          Provider.of<Gudangprovider>(context, listen: false);
                      prov2.addProsesPenerimaan(
                          result['rak'], result['item'], result['qty']);
                    }
                  },
                  child: const Text(
                    "Input Penerimaan",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tambah Vendor'),
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
                                controller: vendorController,
                                decoration: const InputDecoration(
                                    labelText: "Nama Vendor"),
                              ),
                              TextField(
                                controller: alamatVendorController,
                                decoration: const InputDecoration(
                                    labelText: "Alamat Vendor"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text("Vendor Info"),
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
                                      prov.addVendor(vendorController.text,
                                          alamatVendorController.text);
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
                    "Tambah Vendor",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: const ListViewPenerimaan(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InputPenerimaanPage()),
          );

          if (result != null) {
            // Get the data from the result and add it to gudangprovider
            var prov = Provider.of<PenerimaanProvider>(context, listen: false);
            prov.addPenerimaanList(result['vendor'], result['pesanan'],
                result['tanggal'], result['item'], result['qty']);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
