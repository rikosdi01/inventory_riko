import 'dart:io';

import 'package:flutter/material.dart';

class Item {
  String kode;
  String item;
  String satuan;
  int isi;
  int harga;
  List<GudangBaru>? rak;
  List<ItemPersamaan>? persamaan;
  int get totalQty {
    int total = 0;
    rak?.forEach((gudangItem) {
      total += gudangItem.qty;
    });
    return total;
  }

  File? image;

  Item({
    required this.kode,
    required this.item,
    required this.satuan,
    required this.isi,
    required this.harga,
    this.rak,
    this.persamaan,
    this.image,
  });
}

class ItemPersamaan {
  String kategori;
  List<String> item;
  List<String> keterangan;
  List<File?>? image;

  ItemPersamaan(
      {required this.kategori,
      required this.item,
      required this.keterangan,
      this.image});
}

class GudangBaru {
  String rak;
  int qty;

  GudangBaru({required this.rak, required this.qty});
}

class PenerimaanProses {
  String rak;
  List<String> item;
  List<int> qty;

  PenerimaanProses({required this.rak, required this.item, required this.qty});
}

class RakDepot {
  String rakDepot;
  String lokasiDepot;

  RakDepot({
    required this.rakDepot,
    required this.lokasiDepot,
  });
}

class RakF7 {
  String rakF7;
  String lokasiF7;

  RakF7({
    required this.rakF7,
    required this.lokasiF7,
  });
}

class Gudangprovider extends ChangeNotifier {
  final List<Item> itemm = [];
  final List<ItemPersamaan> persamaan = [];
  final List<GudangBaru> _gudang = [];
  final List<PenerimaanProses> _penerimaantambah = [];
  final List<RakDepot> _rakdepot = [];
  final List<RakF7> _rakF7 = [];

  Gudangprovider() {
    //item
    itemm.add(Item(
        image: null,
        kode: "GN5",
        item: "Rocker Arm H. Grand RIKO",
        satuan: "Set",
        isi: 1,
        harga: 20000,
        rak: [
          GudangBaru(rak: "Sales Department", qty: 0),
          GudangBaru(rak: "F7", qty: 0),
          GudangBaru(rak: "Masuk Barang", qty: 0),
          GudangBaru(rak: "Depot", qty: 0),
        ]));
    itemm.add(Item(
        image: null,
        kode: "KPH",
        item: "Botol Klep H. Karisma RIKO",
        satuan: "Set",
        isi: 1,
        harga: 25000,
        rak: [
          GudangBaru(rak: "Sales Department", qty: 0),
          GudangBaru(rak: "F7", qty: 0),
          GudangBaru(rak: "Masuk Barang", qty: 0),
          GudangBaru(rak: "Depot", qty: 0),
        ]));
    itemm.add(Item(
        image: null,
        kode: "KFL",
        item: "Kain Kopling H. Legenda RIKO",
        satuan: "Pcs",
        isi: 1,
        harga: 20000,
        rak: [
          GudangBaru(rak: "Sales Department", qty: 0),
          GudangBaru(rak: "F7", qty: 0),
          GudangBaru(rak: "Masuk Barang", qty: 0),
          GudangBaru(rak: "Depot", qty: 0),
        ]));
    itemm.add(Item(
        image: null,
        kode: "5LW",
        item: "Stelan Tensioner Y. Mio / Nuovo RIKO",
        satuan: "Set",
        isi: 1,
        harga: 20000,
        rak: [
          GudangBaru(rak: "Sales Department", qty: 0),
          GudangBaru(rak: "F7", qty: 0),
          GudangBaru(rak: "Masuk Barang", qty: 0),
          GudangBaru(rak: "Depot", qty: 0),
        ]));
    itemm.add(Item(
      image: null,
      kode: "0104",
      item: "Botol Klep K. KLX-150 RIKO",
      satuan: "Set",
      isi: 1,
      harga: 20000,
      rak: [
        GudangBaru(rak: "Sales Department", qty: 0),
        GudangBaru(rak: "F7", qty: 0),
        GudangBaru(rak: "Masuk Barang", qty: 0),
        GudangBaru(rak: "Depot", qty: 0),
      ],
    ));

    itemm.add(Item(
        image: null,
        kode: "KVY",
        item: "Kain Kopling H. Beat RIKO",
        satuan: "Set",
        isi: 1,
        harga: 20000,
        rak: [
          GudangBaru(rak: "Sales Department", qty: 0),
          GudangBaru(rak: "F7", qty: 0),
          GudangBaru(rak: "Masuk Barang", qty: 0),
          GudangBaru(rak: "Depot", qty: 0),
        ]));
    itemm.add(Item(
        image: null,
        kode: "KVB",
        item: "CDI Unit H. Vario-110 RIKO",
        satuan: "Set",
        isi: 1,
        harga: 20000,
        rak: [
          GudangBaru(rak: "Sales Department", qty: 0),
          GudangBaru(rak: "F7", qty: 0),
          GudangBaru(rak: "Masuk Barang", qty: 0),
          GudangBaru(rak: "Depot", qty: 0),
        ]));

    //tambah persamaan
    persamaan.add(ItemPersamaan(kategori: "Botol Klep", item: [
      "Botol Klep H. Karisma RIKO",
      "Botol Klep K. KLX-150 RIKO",
    ], keterangan: [
      "TES 2",
      "TES 3"
    ], image: [
      itemm
          .firstWhere((item) => item.item == "Botol Klep H. Karisma RIKO")
          .image,
      itemm
          .firstWhere((item) => item.item == "Botol Klep K. KLX-150 RIKO")
          .image,
    ]));
    persamaan.add(ItemPersamaan(kategori: "Kain Kopling", item: [
      "Kain Kopling H. Legenda RIKO",
      "Kain Kopling H. Beat RIKO",
    ], keterangan: [
      "TES 4",
      "TES 5",
    ], image: [
      itemm
          .firstWhere((item) => item.item == "Kain Kopling H. Legenda RIKO")
          .image,
      itemm
          .firstWhere((item) => item.item == "Kain Kopling H. Beat RIKO")
          .image,
    ]));

    //rak
    _gudang.add(GudangBaru(rak: "Sales Department", qty: 0));
    _gudang.add(GudangBaru(rak: "F7", qty: 0));
    _gudang.add(GudangBaru(rak: "Masuk Barang", qty: 0));
    _gudang.add(GudangBaru(rak: "Depot", qty: 0));

    //rak depot
    _rakdepot.add(RakDepot(rakDepot: "AA1", lokasiDepot: "Chamber 3A"));
    _rakdepot.add(RakDepot(rakDepot: "BB2", lokasiDepot: "Chamber 3A"));
    _rakdepot.add(RakDepot(rakDepot: "CC3", lokasiDepot: "Chamber 3A"));
    _rakdepot.add(RakDepot(rakDepot: "DD4", lokasiDepot: "Chamber 3A"));
    _rakdepot.add(RakDepot(rakDepot: "AA5", lokasiDepot: "Chamber 4"));
    _rakdepot.add(RakDepot(rakDepot: "BB5", lokasiDepot: "Chamber 4"));
    _rakdepot.add(RakDepot(rakDepot: "CC5", lokasiDepot: "Chamber 4"));
    _rakdepot.add(RakDepot(rakDepot: "DD5", lokasiDepot: "Chamber 4"));

    _rakF7.add(RakF7(rakF7: "PK1", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK2", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK3", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK4", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK5", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK6", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK7", lokasiF7: "Pallet Besi"));
    _rakF7.add(RakF7(rakF7: "PK8", lokasiF7: "Pallet Besi"));
  }

//item
  addItems(
    String kode,
    String item,
    String satuan,
    int isi,
    int harga,
    File? image,
  ) {
    List<GudangBaru>? itemrak = [];
    for (var gudangrak in _gudang) {
      var gudangraklist = gudangrak.rak;
      int gudangqtylist = gudangrak.qty;
      itemrak.add(GudangBaru(rak: gudangraklist, qty: gudangqtylist));
    }

    List<ItemPersamaan>? persamaanlist = [];

    for (var persamaanItem in persamaan) {
      var itemlist = persamaanItem.item;

      for (int i = 0; i < itemlist.length; i++) {
        if (itemlist[i] == item) {
          var kategories = persamaanItem.kategori;
          var itemlists = persamaanItem.item;
          var keteranganlists = persamaanItem.keterangan;
          var imagelists = persamaanItem.image;

          persamaanlist.add(ItemPersamaan(
              kategori: kategories,
              item: itemlists,
              keterangan: keteranganlists,
              image: imagelists));
        }
      }
    }

    itemm.add(Item(
      kode: kode,
      item: item,
      satuan: satuan,
      isi: isi,
      harga: harga,
      rak: itemrak,
      image: image,
      persamaan: persamaanlist,
    ));

    updatePersamaanImages();

    notifyListeners();
  }

  removeItems(int index) {
    itemm.removeAt(index);
    notifyListeners();
  }

  updateItems(int index, Item updatedItems) {
    updatedItems.rak = itemm[index].rak;

    itemm[index] = updatedItems;

    updatePersamaanImages();
    notifyListeners();
  }

  Item getItemAt(int index) {
    return itemm[index];
  }

//persamaan barang
  addPersamaanItem(
    String kategori,
    List<String> item,
    List<String> keterangan,
  ) {
    List<File?> images = [];

    for (var itemName in item) {
      try {
        var currentItem =
            itemm.firstWhere((element) => element.item == itemName);
        images.add(currentItem.image);
      } catch (e) {
        images.add(null);
      }
    }

    persamaan.add(ItemPersamaan(
        kategori: kategori, item: item, keterangan: keterangan, image: images));

    notifyListeners();
  }

//tambah gudang
  addGudang(String rak) {
    _gudang.add(GudangBaru(rak: rak, qty: 0));
    for (var item in itemm) {
      item.rak?.add(GudangBaru(rak: rak, qty: 0));
    }

    notifyListeners();
  }

  removeRakGudang(int index) {
    _gudang.removeAt(index);
    for (var itemrak in itemm) {
      var rak = itemrak.rak;

      rak!.removeAt(index);
    }
    notifyListeners();
  }

//tambah rak Depot
  addRakDepot(String rakDepot, String lokasiDepot) {
    _rakdepot.add(RakDepot(
      rakDepot: rakDepot,
      lokasiDepot: lokasiDepot,
    ));
    notifyListeners();
  }

  removeRakDepot(int index) {
    _rakdepot.removeAt(index);
    notifyListeners();
  }

//tambah rak F7
  addRakF7(String rakF7, String lokasiF7) {
    _rakF7.add(RakF7(
      rakF7: rakF7,
      lokasiF7: lokasiF7,
    ));
    notifyListeners();
  }

  removeRakF7(int index) {
    _rakF7.removeAt(index);
    notifyListeners();
  }

  //tambah proses penerimaan
  addProsesPenerimaan(String rak, List<String> item, List<int> qty) {
    for (var i = 0; i < itemm.length; i++) {
      var currentItem = itemm[i];
      for (var j = 0; j < item.length; j++) {
        var targetItem = item[j];
        var targetQty = qty[j];
        if (currentItem.item == targetItem) {
          for (var gudangItem in currentItem.rak ?? []) {
            if (gudangItem.rak == rak) {
              gudangItem.qty += targetQty;
              break;
            }
          }
        }
      }
    }
    notifyListeners();
  }

  List<Item> get items => itemm.toList();
  List<ItemPersamaan> get itempersamaan => persamaan.toList();
  List<GudangBaru> get tambahgudang => _gudang.toList();
  List<PenerimaanProses> get tambahpenerimaan => _penerimaantambah.toList();
  List<RakDepot> get rakdepotinfo => _rakdepot.toList();
  List<RakF7> get rakf7info => _rakF7.toList();

  void updatePersamaanImages() {
    for (var persamaanItem in persamaan) {
      List<File?> updatedImages = [];

      for (var itemName in persamaanItem.item) {
        try {
          var currentItem =
              itemm.firstWhere((element) => element.item == itemName);
          updatedImages.add(currentItem.image);
        } catch (e) {
          updatedImages.add(null);
        }
      }

      persamaanItem.image = updatedImages;
    }
  }

//sorting method
  void sortItemByName() {
    Future.microtask(() {
      itemm.sort((a, b) => a.item.compareTo(b.item));
      notifyListeners();
    });
  }

  void sortGudangByName() {
    // Extract rak names from existing items
    List<String> raklist = [];
    for (int i = 0; i < itemm.length; i++) {
      var rak = itemm[i].rak;
      for (int j = 0; j < rak!.length; j++) {
        var rakindex = rak[j].rak;
        raklist.add(rakindex);
      }
    }

    // Remove duplicates and sort
    raklist = raklist.toSet().toList();
    raklist.sort();

    // Assign sorted rak list back to each TambahItem's rak
    for (int i = 0; i < itemm.length; i++) {
      var item = itemm[i];
      item.rak?.sort((a, b) => a.rak.compareTo(b.rak));
    }

    Future.microtask(() {
      notifyListeners();
    });
  }

  void sortGudangItemByName() {
    Future.microtask(() {
      _gudang.sort((a, b) => a.rak.compareTo(b.rak));
      notifyListeners();
    });
  }

  void sortRakDepotByName() {
    Future.microtask(() {
      _rakdepot.sort((a, b) => a.rakDepot.compareTo(b.rakDepot));
      notifyListeners();
    });
  }

  void sortRakF7ByName() {
    Future.microtask(() {
      _rakF7.sort((a, b) => a.rakF7.compareTo(b.rakF7));
      notifyListeners();
    });
  }
}
