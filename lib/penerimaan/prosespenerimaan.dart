import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/gudangprovider.dart';
import '../provider/penerimaanprovider.dart';

class ProsesPenerimaanPage extends StatefulWidget {
  const ProsesPenerimaanPage({super.key});

  @override
  State<ProsesPenerimaanPage> createState() => _ProsesPenerimaanPageState();
}

class _ProsesPenerimaanPageState extends State<ProsesPenerimaanPage> {
  final _dropdownMenuVendorPesananController = TextEditingController();
  final _dropdownMenuRakPenerimaanController = TextEditingController();
  final kodePenerimaanController = TextEditingController();
  final deskripsiController = TextEditingController();
  String? selectedVendor;
  String? selectedPesananValue;
  List<String>? selectedPesanan;
  List<DateTime>? selectedTanggal;
  List<List<String>>? selectedItem;
  List<List<int>>? selectedQty;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var prov2 = Provider.of<PenerimaanProvider>(context);
    var penerimaanlist = prov2.penerimaan;
    var rak = prov.tambahgudang;

    final List<DropdownMenuEntry<TambahPenerimaan>> vendorEntries =
        penerimaanlist.map((vendor) {
      return DropdownMenuEntry<TambahPenerimaan>(
        value: vendor,
        label: vendor.vendor, // Use the appropriate property for the label.
      );
    }).toList();

    final List<DropdownMenuItem<String>> pesananEntries =
        selectedPesanan != null
            ? selectedPesanan!
                .toSet()
                .map((pesanan) => DropdownMenuItem<String>(
                      value: pesanan,
                      child: Text(pesanan),
                    ))
                .toList()
            : [];

    final List<DropdownMenuEntry<GudangBaru>> rakEntries = rak.map((rak) {
      return DropdownMenuEntry<GudangBaru>(
        value: rak,
        label: rak.rak, // Use the appropriate property for the label.
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Penerimaan Barang"),
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
                    DropdownMenu<TambahPenerimaan>(
                      controller: _dropdownMenuVendorPesananController,
                      width: MediaQuery.of(context).size.width * 0.45,
                      label: const Text("Vendor"),
                      dropdownMenuEntries: vendorEntries,
                      onSelected: (vendor) {
                        setState(() {
                          if (vendor != null) {
                            int index = penerimaanlist.indexWhere(
                                (penerimaan) =>
                                    penerimaan.vendor == vendor.vendor);
                            selectedVendor = vendor.vendor;
                            selectedPesanan = penerimaanlist[index].pesanan;
                            // Set other selected fields to null when vendor is selected
                            selectedTanggal = null;
                            selectedItem = null;
                            selectedQty = null;
                          }
                        });

                        if (vendor != null && selectedPesananValue != null) {
                          setState(() {
                            selectedPesananValue = null;
                            selectedTanggal = null;
                            selectedItem = null;
                            selectedQty = null;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: DropdownButton<String>(
                              items: pesananEntries,
                              value: selectedPesananValue,
                              onChanged: (pesanan) {
                                setState(() {
                                  selectedPesananValue = pesanan ?? "";
                                  if (pesanan != null) {
                                    var selectedPenerimaan;
                                    for (var penerimaan in penerimaanlist) {
                                      if (penerimaan.pesanan
                                          .contains(pesanan)) {
                                        selectedPenerimaan = penerimaan;
                                        break;
                                      }
                                    }
                                    if (selectedPenerimaan != null) {
                                      selectedPesanan =
                                          selectedPenerimaan.pesanan;
                                      selectedTanggal =
                                          selectedPenerimaan.tanggal;

                                      selectedItem = [
                                        selectedPenerimaan.items[
                                            selectedPesanan!.indexOf(pesanan)]
                                      ];
                                      selectedQty = [
                                        selectedPenerimaan.qtys[
                                            selectedPesanan!.indexOf(pesanan)]
                                      ];
                                    } else {
                                      // Handle the case where no matching penerimaan is found
                                      selectedPesanan = null;
                                      selectedTanggal = null;
                                      selectedItem = null;
                                      selectedQty = null;
                                    }
                                  } else {
                                    selectedPesanan =
                                        null; // Clear the selection
                                    selectedTanggal = null;
                                    selectedItem = null;
                                    selectedQty = null;
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 127, 127, 127),
                              ),
                              underline: Container(),
                            ),
                          ),
                        ),
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
                    controller: kodePenerimaanController,
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
                  controller: _dropdownMenuRakPenerimaanController,
                  width: MediaQuery.of(context).size.width * 0.18,
                  label: const Text("Rak"),
                  dropdownMenuEntries: rakEntries,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 48,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: selectedTanggal != null &&
                                selectedTanggal!.isNotEmpty
                            ? DateFormat('dd-MM-yyyy')
                                .format(selectedTanggal![0])
                            : "Tanggal",
                        border: const OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          //item & rak
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                if (selectedPesanan != null)
                  for (var penerimaan in penerimaanlist)
                    if (penerimaan.vendor == selectedVendor &&
                        penerimaan.pesanan == selectedPesanan &&
                        selectedItem != null &&
                        selectedQty != null)
                      for (var iteminlist in selectedItem!)
                        for (var qtylist in selectedQty!)
                          ...List.generate(
                              selectedItem != null ? iteminlist.length : 0,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Wrap the TextField with a SizedBox to provide constraints.
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    height: 48,
                                    child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                            labelText: iteminlist.isNotEmpty &&
                                                    iteminlist.length > index
                                                ? iteminlist[index]
                                                : '',
                                            border:
                                                const OutlineInputBorder())),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height: 48,
                                      child: TextField(
                                          keyboardType: TextInputType.number,
                                          enabled: false,
                                          decoration: InputDecoration(
                                              labelText: qtylist.isNotEmpty &&
                                                      qtylist.length > index
                                                  ? qtylist[index].toString()
                                                  : '',
                                              border:
                                                  const OutlineInputBorder()))),
                                ],
                              ),
                            );
                          })
              ]),
            ),
          ),
          const Divider(),

          //bottom layer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: deskripsiController,
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
                    String selectedVendor =
                        _dropdownMenuVendorPesananController.text;
                    // Provider.of<PenerimaanProvider>(context, listen: false)
                    //     .removePenerimaanByVendor(selectedVendor);
                    String selectedPesanans = selectedPesananValue!;
                    String selectedRak =
                        _dropdownMenuRakPenerimaanController.text;
                    String selectedKodePenerimaan =
                        kodePenerimaanController.text;
                    String selectedDeskripsi = deskripsiController.text;
                    List<String> selectedItems = [];
                    for (var iteminlist in selectedItem!) {
                      var selectedItemlist2 = iteminlist;
                      for (var item in selectedItemlist2) {
                        var selectedItemlist1 = item;
                        selectedItems.add(selectedItemlist1);
                      }
                    }

                    List<int> selectedQtys = [];
                    for (var qtyinlist in selectedQty!) {
                      var selectedQtylist2 = qtyinlist;
                      for (var qty in selectedQtylist2) {
                        var selectedQtylist1 = qty;
                        selectedQtys.add(selectedQtylist1);
                      }
                    }

                    // Pass the selected data back to GudangPage using Navigator.pop
                    Navigator.pop(
                      context,
                      {
                        'vendor': selectedVendor,
                        'pesanan': selectedPesanans,
                        'kode': selectedKodePenerimaan,
                        'tanggal': selectedTanggal![0],
                        'rak': selectedRak,
                        'item': selectedItems,
                        'qty': selectedQtys,
                        'deskripsi': selectedDeskripsi,
                      },
                    );
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
