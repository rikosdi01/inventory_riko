import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/provider/penerimaanprovider.dart';

import '../provider/gudangprovider.dart';

class InputPenerimaanPage extends StatefulWidget {
  const InputPenerimaanPage({super.key});

  @override
  State<InputPenerimaanPage> createState() => _InputPenerimaanPageState();
}

class _InputPenerimaanPageState extends State<InputPenerimaanPage> {
  // final List<TextEditingController> _dropdownMenuVendorControllers = [];
  // final List<TextEditingController> qtyControllers = [];
  final _dropdownMenuVendorController = TextEditingController();
  final _dropdownMenuItemPenerimaanController = TextEditingController();
  final pesananController = TextEditingController();
  final qtyController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var prov2 = Provider.of<PenerimaanProvider>(context);
    var item = prov.items;
    var vendor = prov2.vendorlist;

    // vendor.sort((a, b) => a.vendor.compareTo(b.vendor));

    final List<DropdownMenuEntry<Item>> itemEntries = item.map((item) {
      return DropdownMenuEntry<Item>(
        value: item,
        label: item.item, // Use the appropriate property for the label.
      );
    }).toList();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu<Vendor>(
                  controller: _dropdownMenuVendorController,
                  width: MediaQuery.of(context).size.width * 0.4,
                  label: const Text("Vendor"),
                  dropdownMenuEntries: vendorEntries,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextField(
                    controller: pesananController,
                    decoration: const InputDecoration(
                        labelText: "Pesanan", border: OutlineInputBorder()),
                  ),
                ),
              ),
            ],
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
                          width: MediaQuery.of(context).size.width * 0.142,
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
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Wrap the TextField with a SizedBox to provide constraints.
                  DropdownMenu<Item>(
                    controller: _dropdownMenuItemPenerimaanController,
                    width: MediaQuery.of(context).size.width * 0.80,
                    label: const Text("Item"),
                    dropdownMenuEntries: itemEntries,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextField(
                      controller: qtyController,
                      decoration: const InputDecoration(
                          labelText: "Qty", border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            )
          ]),
          // Column(
          //     children: List.generate(2, (index) {
          //   final qtyController = TextEditingController();
          //   return Padding(
          //       padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
          //       child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             // Wrap the TextField with a SizedBox to provide constraints.
          //             DropdownMenu<TambahItem>(
          //               controller: dropdownMenuItemPenerimaanController,
          //               width: MediaQuery.of(context).size.width * 0.80,
          //               label: const Text("Item"),
          //               dropdownMenuEntries: itemEntries,
          //             ),
          //             SizedBox(
          //               width: MediaQuery.of(context).size.width * 0.02,
          //             ),
          //             SizedBox(
          //                 width: MediaQuery.of(context).size.width * 0.1,
          //                 child: TextField(
          //                   controller: qtyController,
          //                   decoration: const InputDecoration(
          //                       labelText: "Qty", border: OutlineInputBorder()),
          //                 ))
          //           ]));
          // })),
          Center(
            child: TextButton(
                onPressed: () {
                  String selectedVendor = _dropdownMenuVendorController.text;
                  String selectedPesanan = pesananController.text;
                  DateTime selectedTanggal = _selectedDate;
                  String selectedItem =
                      _dropdownMenuItemPenerimaanController.text;
                  int selectedQty = int.parse(qtyController.text);
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
                child: const Text("Simpan")),
          ),
        ],
      ),
    );
  }
}
