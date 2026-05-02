import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/provider/penerimaanprovider.dart';

class InputPenerimaanPage extends StatefulWidget {
  const InputPenerimaanPage({super.key});

  @override
  State<InputPenerimaanPage> createState() => _InputPenerimaanPageState();
}

class _InputPenerimaanPageState extends State<InputPenerimaanPage> {
  final List<TextEditingController> itemControllers = [];
  final List<TextEditingController> qtyControllers = [];
  final _dropdownMenuVendorController = TextEditingController();
  final pesananController = TextEditingController();
  var columnAddition = 1;
  bool showAdditionalColumn = false;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var prov2 = Provider.of<PenerimaanProvider>(context);
    var vendor = prov2.vendorlist;

    // vendor.sort((a, b) => a.vendor.compareTo(b.vendor));

    final List<DropdownMenuEntry<Vendor>> vendorEntries = vendor.map((vendor) {
      return DropdownMenuEntry<Vendor>(
        value: vendor,
        label: vendor.vendor, // Use the appropriate property for the label.
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
                DropdownMenu<Vendor>(
                  controller: _dropdownMenuVendorController,
                  width: MediaQuery.of(context).size.width * 0.45,
                  label: const Text("Vendor"),
                  dropdownMenuEntries: vendorEntries,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 48,
                  child: TextField(
                    controller: pesananController,
                    decoration: const InputDecoration(
                        labelText: "Pesanan", border: OutlineInputBorder()),
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
                const SizedBox(
                  width: 20,
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
                          width: MediaQuery.of(context).size.width * 0.122,
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
                final itemController = itemControllers.length > index
                    ? itemControllers[index]
                    : TextEditingController();
                if (itemControllers.length <= index) {
                  itemControllers.add(itemController);
                }

                final qtyController = qtyControllers.length > index
                    ? qtyControllers[index]
                    : TextEditingController();
                if (qtyControllers.length <= index) {
                  qtyControllers.add(qtyController);
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
            child: Center(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.blue),
                child: TextButton(
                    onPressed: () {
                      String selectedVendor =
                          _dropdownMenuVendorController.text;
                      // String selectedPesanan = pesananController.text;
                      // DateTime selectedTanggal = _selectedDate;
                      List<String> selectedPesanan = [];
                      List<DateTime> selectedTanggal = [];

                      List<List<String>> selectedItem = [];
                      List<List<int>> selectedQty = [];

                      for (int i = 0; i < itemControllers.length; i++) {
                        String item = itemControllers[i].text;
                        int qty = int.tryParse(qtyControllers[i].text) ?? 0;
                        if (item.isNotEmpty || qty > 0) {
                          // Check if the selectedPesanan list already contains the current pesanan
                          int pesananIndex =
                              selectedPesanan.indexOf(pesananController.text);
                          if (pesananIndex == -1) {
                            // If the pesanan is not in the selectedPesanan list, create a new group
                            selectedPesanan.add(pesananController.text);
                            selectedItem.add([
                              item
                            ]); // Create a new list with the current item
                            selectedQty.add([
                              qty
                            ]); // Create a new list with the current qty
                          } else {
                            // If the pesanan is already in the selectedPesanan list, add the item and qty to the corresponding group
                            selectedItem[pesananIndex].add(item);
                            selectedQty[pesananIndex].add(qty);
                          }
                        }
                      }

                      DateTime tanggal = _selectedDate;
                      selectedTanggal.add(tanggal);

                      Navigator.pop(
                        context,
                        {
                          'vendor': selectedVendor,
                          'pesanan': selectedPesanan,
                          'tanggal': selectedTanggal,
                          'item': selectedItem,
                          'qty': selectedQty,
                        },
                      );
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
    for (int i = 0; i < itemControllers.length; i++) {
      if (itemControllers[i].text.isNotEmpty ||
          qtyControllers[i].text.isNotEmpty) {
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
