import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TambahPersamaan extends StatefulWidget {
  const TambahPersamaan({super.key});

  @override
  State<TambahPersamaan> createState() => _TambahPersamaanState();
}

class _TambahPersamaanState extends State<TambahPersamaan> {
  var columnAddition = 1;
  bool showAdditionalColumn = false;
  final kategoriControllers = TextEditingController();
  final List<TextEditingController> itemControllers = [];
  final List<TextEditingController> keteranganControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Persamaan"),
          actions: [
            TextButton(
                onPressed: () {
                  final kategori = kategoriControllers.text;

                  List<String> selectedItem = [];
                  List<String> selectedKeterangan = [];

                  for (int i = 0; i < itemControllers.length; i++) {
                    String item = itemControllers[i].text;
                    String keteranganitem = keteranganControllers[i].text;
                    if (item.isNotEmpty || keteranganitem.isNotEmpty) {
                      selectedItem.add(item);
                      selectedKeterangan.add(keteranganitem);
                    }
                  }

                  Navigator.pop(
                    context,
                    {
                      'kategori': kategori,
                      'item': selectedItem,
                      'keterangan': selectedKeterangan,
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  controller: kategoriControllers,
                  decoration: const InputDecoration(
                      labelText: "Kategori Barang",
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(),

            //persamaan
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: List.generate(columnAddition, (index) {
                  final itemController = itemControllers.length > index
                      ? itemControllers[index]
                      : TextEditingController();
                  if (itemControllers.length <= index) {
                    itemControllers.add(itemController);
                  }

                  final keteranganController =
                      keteranganControllers.length > index
                          ? keteranganControllers[index]
                          : TextEditingController();
                  if (keteranganControllers.length <= index) {
                    keteranganControllers.add(keteranganController);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Wrap the TextField with a SizedBox to provide constraints.
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 20),
                              child: Text("Item ke-${(index + 1).toString()}",
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold)))),
                          TextField(
                            controller: itemController,
                            onChanged: (_) {
                              checkShowAdditionalColumn();
                            },
                            decoration: const InputDecoration(
                                labelText: "Item",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: keteranganController,
                            minLines: 3, // Adjust this value as needed
                            maxLines: null, // Allows for unlimited lines
                            onChanged: (_) {
                              checkShowAdditionalColumn();
                            },
                            decoration: const InputDecoration(
                              labelText: "Keterangan",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                        ]),
                  );
                })),
              ),
            )
          ],
        ));
  }

  void checkShowAdditionalColumn() {
    int lastFilledColumn = -1;

    // Cari indeks kolom terakhir yang memiliki isian
    for (int i = 0; i < itemControllers.length; i++) {
      if (itemControllers[i].text.isNotEmpty ||
          keteranganControllers[i].text.isNotEmpty) {
        lastFilledColumn = i;
      }
    }

    // Tentukan jumlah kolom tambahan berdasarkan kolom terakhir yang terisi
    if (lastFilledColumn == -1) {
      // Jika tidak ada kolom terisi, maka tampilkan satu kolom saja
      setState(() {
        showAdditionalColumn = false;
        columnAddition = 1;
      });
    } else {
      // Jika ada kolom terisi, maka tampilkan kolom sesuai indeks terakhir yang terisi
      setState(() {
        showAdditionalColumn = true;
        columnAddition = lastFilledColumn +
            2; // +2 karena indeks dimulai dari 0 dan kita ingin menambah satu kolom lagi.
      });
    }
  }
}
