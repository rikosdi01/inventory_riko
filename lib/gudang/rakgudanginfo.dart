import 'package:flutter/material.dart';
import 'package:rikoparts/gudang/widgets/listviewgudanginfo.dart';

class RakGudangInfo extends StatefulWidget {
  const RakGudangInfo({super.key});

  @override
  State<RakGudangInfo> createState() => _RakGudangInfoState();
}

class _RakGudangInfoState extends State<RakGudangInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rak Gudang Info")),
      body: const ListViewGudangInfo(),
    );
  }
}
