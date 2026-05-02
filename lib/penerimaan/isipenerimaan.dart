import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/provider/penerimaanprovider.dart';

import '../provider/gudangprovider.dart';

class IsiPenerimaanPage extends StatefulWidget {
  final int index;

  IsiPenerimaanPage({required this.index});

  @override
  State<IsiPenerimaanPage> createState() => _IsiPenerimaanPageState();
}

class _IsiPenerimaanPageState extends State<IsiPenerimaanPage> {
  late TextEditingController _vendorController;
  late TextEditingController _pesananController;
  late TextEditingController _kodeController;
  late TextEditingController _tanggalController;
  late TextEditingController _rakController;
  late List<TextEditingController> _itemController = [];
  late List<TextEditingController> _qtyController = [];
  late TextEditingController _deskripsiController;
  late int columnAddition;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PenerimaanProvider>(context, listen: false);
    final penerimaan = provider.getPenerimaanAt(widget.index);

    _vendorController = TextEditingController(text: penerimaan.vendor);
    _pesananController = TextEditingController(text: penerimaan.pesanan);
    _kodeController = TextEditingController(text: penerimaan.kode);
    _tanggalController =
        TextEditingController(text: penerimaan.tanggal.toString());
    _rakController = TextEditingController(text: penerimaan.rak);
    _deskripsiController = TextEditingController(text: penerimaan.deskripsi);

    for (var i = 0; i < penerimaan.item.length; i++) {
      _itemController.add(TextEditingController(text: penerimaan.item[i]));
    }

    for (var i = 0; i < penerimaan.qty.length; i++) {
      _qtyController
          .add(TextEditingController(text: penerimaan.qty[i].toString()));

      columnAddition = penerimaan.item.length + 1;
    }
  }

  @override
  void dispose() {
    _vendorController.dispose();
    _pesananController.dispose();
    _kodeController.dispose();
    _tanggalController.dispose();
    _rakController.dispose();
    _deskripsiController.dispose();

    for (var controller in _itemController) {
      controller.dispose();
    }

    for (var controller in _qtyController) {
      controller.dispose();
    }
    super.dispose();
  }

  bool showAdditionalColumn = false;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var rak = prov.tambahgudang;

    final List<DropdownMenuEntry<GudangBaru>> rakEntries = rak.map((rak) {
      return DropdownMenuEntry<GudangBaru>(
        value: rak,
        label: rak.rak, // Use the appropriate property for the label.
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Penerimaan"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //top layer
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 48,
                      child: TextField(
                        enabled: false,
                        controller: _vendorController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: 48,
                      child: TextField(
                        enabled: false,
                        controller: _pesananController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 48,
                  child: TextField(
                    controller: _kodeController,
                    decoration: const InputDecoration(
                        labelText: "Kode", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu<GudangBaru>(
                  controller: _rakController,
                  width: MediaQuery.of(context).size.width * 0.18,
                  label: const Text("Rak"),
                  dropdownMenuEntries: rakEntries,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                // Set the primary color to transparent to remove the underline
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        border: InputBorder.none)),
                            child: InputDatePickerFormField(
                              initialDate: _selectedDate,
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2250),
                              fieldHintText: "Tanggal",
                              onDateSubmitted: (date) {
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          var res = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2250),
                          );

                          if (res != null) {
                            setState(() {
                              _selectedDate = res;
                            });
                          }
                        },
                        icon: const Icon(Icons.date_range),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),

          //item & qty
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(columnAddition, (index) {
                final itemController = _itemController.length > index
                    ? _itemController[index]
                    : TextEditingController();
                if (_itemController.length <= index) {
                  _itemController.add(itemController);
                }

                final qtyController = _qtyController.length > index
                    ? _qtyController[index]
                    : TextEditingController();
                if (_qtyController.length <= index) {
                  _qtyController.add(qtyController);
                }

                return Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Wrap the TextField with a SizedBox to provide constraints.
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              height: 48,
                              child: TextField(
                                controller: itemController,
                                onChanged: (_) {
                                  checkShowAdditionalColumn();
                                },
                                decoration: const InputDecoration(
                                    labelText: "Item",
                                    border: OutlineInputBorder()),
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: 48,
                              child: TextField(
                                controller: qtyController,
                                onChanged: (_) {
                                  checkShowAdditionalColumn();
                                },
                                decoration: const InputDecoration(
                                    labelText: "Qty",
                                    border: OutlineInputBorder()),
                              )),
                        ]));
              })),
            ),
          ),
          const Divider(),

          //bottom layer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                    labelText: 'Deskripsi : ', border: OutlineInputBorder()),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.blue),
                child: TextButton(
                    onPressed: () {
                      final vendor = _vendorController.text;
                      final pesanan = _pesananController.text;
                      final kode = _kodeController.text;
                      final rak = _rakController.text;
                      final deskripsi = _deskripsiController.text;

                      List<String> item = [];
                      List<int> qty = [];

                      for (int i = 0; i < _itemController.length; i++) {
                        String items = _itemController[i].text;
                        int qtys = int.tryParse(_qtyController[i].text) ?? 0;
                        if (items.isNotEmpty || qtys > 0) {
                          item.add(items);
                          qty.add(qtys);
                        }
                      }

                      final provider = Provider.of<PenerimaanProvider>(context,
                          listen: false);
                      final updatedPenerimaan = Penerimaan(
                          vendor: vendor,
                          pesanan: pesanan,
                          kode: kode,
                          tanggal: _selectedDate,
                          rak: rak,
                          item: item,
                          qty: qty,
                          deskripsi: deskripsi);
                      provider.updatePenerimaan(
                          widget.index, updatedPenerimaan);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkShowAdditionalColumn() {
    int lastFilledColumn = -1;

    // Cari indeks kolom terakhir yang memiliki isian
    for (int i = 0; i < _itemController.length; i++) {
      if (_itemController[i].text.isNotEmpty ||
          _qtyController[i].text.isNotEmpty) {
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
