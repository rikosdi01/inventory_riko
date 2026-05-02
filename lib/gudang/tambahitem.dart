import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TambahItemPage extends StatefulWidget {
  const TambahItemPage({super.key});

  @override
  State<TambahItemPage> createState() => _TambahItemPageState();
}

class _TambahItemPageState extends State<TambahItemPage> {
  final kodeController = TextEditingController();
  final itemController = TextEditingController();
  final hargaController = TextEditingController();
  final satuanController = TextEditingController();
  final isiController = TextEditingController();
  File? _imageFile;

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[500]!, width: 2)),
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
                      controller: kodeController,
                      decoration: const InputDecoration(
                          labelText: 'Kode Barang',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: itemController,
                      decoration: const InputDecoration(
                          labelText: 'Nama Barang',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: hargaController,
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
                            controller: isiController,
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
                            controller: satuanController,
                            decoration: const InputDecoration(
                                labelText: 'Satuan',
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.blue),
                  child: TextButton(
                    onPressed: () {
                      String selectedKode = kodeController.text;
                      String selectedItem = itemController.text;
                      int selectedHarga = int.parse(hargaController.text);
                      int selectedIsi = int.parse(isiController.text);
                      String selectedSatuan = satuanController.text;
                      File? selectedImage = _imageFile;

                      Navigator.pop(
                        context,
                        {
                          'kode': selectedKode,
                          'item': selectedItem,
                          'harga': selectedHarga,
                          'isi': selectedIsi,
                          'satuan': selectedSatuan,
                          'image': selectedImage,
                        },
                      );
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
