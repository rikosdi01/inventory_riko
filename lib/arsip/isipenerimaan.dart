import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/penerimaanprovider.dart';

class IsiPenerimaanPage extends StatefulWidget {
  final String? selectedVendor;
  final DateTime? selectedTanggal;
  final String? selectedPesanan;
  final String? selectedKode;
  final String? selectedRak;
  final String? selectedDeskripsi;

  const IsiPenerimaanPage({
    super.key,
    this.selectedVendor,
    this.selectedTanggal,
    this.selectedPesanan,
    this.selectedKode,
    this.selectedRak,
    this.selectedDeskripsi,
  });

  @override
  State<IsiPenerimaanPage> createState() => _IsiPenerimaanPageState();
}

class _IsiPenerimaanPageState extends State<IsiPenerimaanPage> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<PenerimaanProvider>(context);
    var penerimaanlist = prov.semuapenerimaan;

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
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 48,
                        child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: widget.selectedVendor,
                                border: const OutlineInputBorder()))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: 48,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: widget.selectedPesanan,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 48,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: widget.selectedKode,
                        border: const OutlineInputBorder()),
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
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: 48,
                    child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: widget.selectedRak,
                          border: const OutlineInputBorder(),
                        ))),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 48,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: widget.selectedTanggal != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(widget.selectedTanggal!)
                            : '',
                        border: const OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          //item & qty
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var penerimaan in penerimaanlist)
                    if (penerimaan.pesanan == widget.selectedPesanan)
                      ...List.generate(penerimaan.item.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Wrap the TextField with a SizedBox to provide constraints.
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 48,
                                child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        labelText: penerimaan.item[index],
                                        border: const OutlineInputBorder())),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height: 48,
                                  child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          labelText:
                                              penerimaan.qty[index].toString(),
                                          border: const OutlineInputBorder()))),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
          const Divider(),

          //bottom layer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 48,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    labelText: widget.selectedDeskripsi,
                    border: const OutlineInputBorder()),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
