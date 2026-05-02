import 'package:flutter/material.dart';

class Penerimaan {
  String vendor;
  String pesanan;
  String kode;
  DateTime tanggal;
  String rak;
  List<String> item;
  List<int> qty;
  String deskripsi;

  Penerimaan(
      {required this.vendor,
      required this.pesanan,
      required this.kode,
      required this.tanggal,
      required this.rak,
      required this.item,
      required this.qty,
      required this.deskripsi});
}

class Vendor {
  String vendor;
  String alamat;

  Vendor({required this.vendor, required this.alamat});
}

class TambahPenerimaan {
  String vendor;
  List<String> pesanan;
  List<DateTime> tanggal;
  List<List<String>> items;
  List<List<int>> qtys;

  TambahPenerimaan(
      {required this.vendor,
      required this.pesanan,
      required this.tanggal,
      required this.items,
      required this.qtys});
}

class PenerimaanProvider extends ChangeNotifier {
  final List<Penerimaan> _penerimaan = [];
  final List<Vendor> _vendor = [];
  final List<TambahPenerimaan> _penerimaanlist = [];


  PenerimaanProvider() {
    //Vendor
    _vendor.add(Vendor(vendor: "ABA", alamat: "Inggris"));
    _vendor.add(Vendor(vendor: "Baotiep", alamat: "China"));
    _vendor.add(Vendor(vendor: "Chongqing", alamat: "Taiwan"));

    // Penerimaan Tambah
    _penerimaanlist.add(TambahPenerimaan(vendor: "ABA", pesanan: [
      "RI001",
      "RI002",
    ], tanggal: [
      DateTime(2023, 8, 3),
      DateTime(2023, 8, 5),
    ], items: [
      ["Rocker Arm H. Grand RIKO", "Botol Klep H. Karisma RIKO"],
      ["Kain Kopling H. Beat RIKO", "Kain Kopling H. Legenda RIKO"],
    ], qtys: [
      [500, 500],
      [1000, 1000]
    ]));
    _penerimaanlist.add(TambahPenerimaan(vendor: "Baotiep", pesanan: [
      "RI003",
    ], tanggal: [
      DateTime(2023, 8, 6),
    ], items: [
      ["CDI Unit H. Vario-110 RIKO", "Botol Klep H. Karisma RIKO"],
    ], qtys: [
      [500, 1000],
    ]));
    _penerimaanlist.add(TambahPenerimaan(vendor: "Chongqing", pesanan: [
      "RI004",
    ], tanggal: [
      DateTime(2023, 8, 2),
    ], items: [
      [
        "Stelan Tensioner Y. Mio / Nuovo RIKO",
        "Botol Klep K. KLX-150 RIKO",
        "Kain Kopling H. Beat RIKO",
        "Kain Kopling H. Legenda RIKO",
        "CDI Unit H. Vario-110 RIKO",
        "Rocker Arm H. Grand RIKO",
        "Botol Klep H. Karisma RIKO",
      ],
    ], qtys: [
      [1000, 2000, 3000, 4000, 5000, 6000, 7000],
    ]));
  }

//penerimaan
  addPenerimaan(String vendor, String pesanan, String kode, DateTime tanggal,
      String rak, List<String> item, List<int> qty, String deskripsi) {
    _penerimaan.add(Penerimaan(
        vendor: vendor,
        pesanan: pesanan,
        kode: kode,
        tanggal: tanggal,
        rak: rak,
        item: item,
        qty: qty,
        deskripsi: deskripsi));
        

    int pesananIndex = _penerimaanlist.indexWhere(
      (item) => item.vendor == vendor && item.pesanan.contains(pesanan),
    );

    if (pesananIndex != -1) {
      // Retrieve the existing entry from _penerimaanlist
      TambahPenerimaan existingEntry = _penerimaanlist[pesananIndex];

      // Remove the selected pesanan, tanggal, item, and qty from the entry
      existingEntry.pesanan.remove(pesanan);
      existingEntry.tanggal.remove(tanggal);

      bool listEquals(List<String> a, List<String> b) {
        if (a.length != b.length) return false;
        for (int i = 0; i < a.length; i++) {
          if (a[i] != b[i]) return false;
        }
        return true;
      }

      bool intListEquals(List<int> a, List<int> b) {
        if (a.length != b.length) return false;
        for (int i = 0; i < a.length; i++) {
          if (a[i] != b[i]) return false;
        }
        return true;
      }

      // Remove matching items and qtys from the existingEntry
      existingEntry.items.removeWhere((list) => listEquals(list, item));
      existingEntry.qtys.removeWhere((list) => intListEquals(list, qty));

      // If all pesanan entries are removed from the existing entry, remove the entire entry
      if (existingEntry.pesanan.isEmpty) {
        _penerimaanlist.removeAt(pesananIndex);
      }
    }

    notifyListeners();
  }

  updatePenerimaan(int index, Penerimaan updatedPenerimaan) {
    _penerimaan[index] = updatedPenerimaan;
    notifyListeners();
  }

  Penerimaan getPenerimaanAt(int index) {
    return _penerimaan[index];
  }

//vendor
  addVendor(String vendor, String alamat) {
    _vendor.add(Vendor(vendor: vendor, alamat: alamat));
    notifyListeners();
  }

//tambah penerimaan
  addPenerimaanList(String vendor, List<String> pesanan, List<DateTime> tanggal,
      List<List<String>> items, List<List<int>> qtys) {
    int existingVendorIndex =
        _penerimaanlist.indexWhere((element) => element.vendor == vendor);

    if (existingVendorIndex != -1) {
      // Vendor exists, update the data
      var existingVendor = _penerimaanlist[existingVendorIndex];

      existingVendor.pesanan.addAll(pesanan);
      existingVendor.tanggal.addAll(tanggal); // Add multiple dates
      existingVendor.items.addAll(items);
      existingVendor.qtys.addAll(qtys);
    } else {
      // Vendor does not exist, add a new entry
      _penerimaanlist.add(TambahPenerimaan(
        vendor: vendor,
        pesanan: pesanan,
        tanggal: tanggal, // Add multiple dates
        items: items,
        qtys: qtys,
      ));
    }

    notifyListeners();
  }

  List<Penerimaan> get semuapenerimaan => _penerimaan.toList();
  List<Vendor> get vendorlist => _vendor.toList();
  List<TambahPenerimaan> get penerimaan => _penerimaanlist.toList();

  void sortVendorByName() {
    Future.microtask(() {
      _vendor.sort((a, b) => a.vendor.compareTo(b.vendor));
      notifyListeners();
    });
  }
}
