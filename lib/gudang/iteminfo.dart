import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/edititem.dart';
import 'package:rikoparts/gudang/widgets/dialogdelete.dart';

import '../provider/gudangprovider.dart';

class ItemInfoPage extends StatefulWidget {
  final File? selectedImage;
  final String? selectedItem;
  final String? selectedKode;
  final int? selectedHarga;
  final String? selectedSatuan;
  final int? selectedIsi;

  const ItemInfoPage({
    super.key,
    this.selectedImage,
    this.selectedItem,
    this.selectedKode,
    this.selectedHarga,
    this.selectedSatuan,
    this.selectedIsi,
  });

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    var prov = Provider.of<Gudangprovider>(context, listen: false);
    var itemlist = prov.items;

    // Calculate selectedIndex here
    selectedIndex =
        itemlist.indexWhere((item) => item.item == widget.selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var itemlist = prov.items;
    var dialog = MyDialogItems();

    // Check if the selected item was not found
    List<ItemPersamaan>? persamaanList;
    if (selectedIndex != -1) {
      persamaanList = itemlist[selectedIndex].persamaan;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Info"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  var currentIndex = itemlist
                      .indexWhere((item) => item.item == widget.selectedItem);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditItemIndex(index: currentIndex)));
                },
                icon: const Icon(Icons.edit)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  var currentIndex = itemlist
                      .indexWhere((item) => item.item == widget.selectedItem);
                  print(currentIndex);
                  showDialog(
                      context: context,
                      builder: (_) => dialog.getDialog(context, currentIndex));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.circular(5.0)),
                width: 500,
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.selectedImage !=
                        null) // Check if the image is not null
                      SizedBox(
                        height: 300,
                        child: Center(
                          child: kIsWeb
                              ? Image.network(widget.selectedImage!.path,
                                  fit: BoxFit.contain) // For Flutter Web
                              : Image.file(widget.selectedImage!,
                                  fit: BoxFit.contain), // For Flutter Mobile
                        ),
                      )
                    else
                      SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "No Image",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  "Nama Barang :",
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${widget.selectedItem}",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text("Kode Barang :",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36))),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${widget.selectedKode}",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text("Isi Barang :",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36))),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${widget.selectedIsi} ${widget.selectedSatuan}",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text("Harga Barang :",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36))),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${widget.selectedHarga}",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 3),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Persamaan :",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36)),
                            ),
                            if (persamaanList != null)
                              for (var persamaanlist in persamaanList)
                                Column(
                                  children: [
                                    Text(persamaanlist.kategori),
                                    Text("${persamaanlist.image}"),
                                    Text("${persamaanlist.item}"),
                                    Text("${persamaanlist.keterangan}"),
                                  ],
                                )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
