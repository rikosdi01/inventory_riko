import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/iteminfo.dart';
import 'dart:io';

import 'package:rikoparts/provider/gudangprovider.dart';

class EditItemIndex extends StatefulWidget {
  final int index;

  const EditItemIndex({super.key, required this.index});

  @override
  EditItemIndexState createState() => EditItemIndexState();
}

class EditItemIndexState extends State<EditItemIndex> {
  late TextEditingController _kodeController;
  late TextEditingController _itemController;
  late TextEditingController _hargaController;
  late TextEditingController _satuanController;
  late TextEditingController _isiController;
  late File? _imageFile;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<Gudangprovider>(context, listen: false);
    final items = provider.getItemAt(widget.index);

    _kodeController = TextEditingController(text: items.kode);
    _itemController = TextEditingController(text: items.item);
    _hargaController = TextEditingController(text: items.harga.toString());
    _satuanController = TextEditingController(text: items.satuan);
    _isiController = TextEditingController(text: items.isi.toString());
    _imageFile = items.image;
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _itemController.dispose();
    _hargaController.dispose();
    _satuanController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Item"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[500]!, width: 2)),
                height: 400,
                width: MediaQuery.of(context).size.width * 0.80,
                // color: Colors.grey[300],
                child: _imageFile != null
                    ? kIsWeb
                        ? Image.network(
                            _imageFile!.path,
                            fit: BoxFit.contain,
                          ) // For Flutter Web
                        : Image.file(
                            _imageFile!,
                            fit: BoxFit.contain,
                          ) // For Flutter Mobile
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: _pickImage,
                child: const Text("Tambah Foto"),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _kodeController,
                decoration: const InputDecoration(
                    labelText: 'Kode Barang', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _itemController,
                decoration: const InputDecoration(
                    labelText: 'Nama Barang', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: _hargaController,
                      decoration: const InputDecoration(
                          labelText: 'Harga Barang',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const Text(
                    "/",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextField(
                      controller: _isiController,
                      decoration: const InputDecoration(
                          labelText: 'isi', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextField(
                      controller: _satuanController,
                      decoration: const InputDecoration(
                          labelText: 'Satuan', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Persamaan : ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
              ),
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
                          final kode = _kodeController.text;
                          final item = _itemController.text;
                          final harga = int.tryParse(_hargaController.text);
                          final satuan = _satuanController.text;
                          final isi = int.tryParse(_isiController.text);
                          final image = _imageFile;

                          final provider = Provider.of<Gudangprovider>(context,
                              listen: false);
                          final updatedItem = Item(
                              image: image,
                              kode: kode,
                              item: item,
                              satuan: satuan,
                              isi: isi!,
                              harga: harga!);
                          provider.updateItems(widget.index, updatedItem);

                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemInfoPage(
                                selectedImage: image,
                                selectedItem: item,
                                selectedKode: kode,
                                selectedHarga: harga,
                                selectedSatuan: satuan,
                                selectedIsi: isi,
                              ),
                            ),
                          );
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
        ),
      ),
    );
  }
}
