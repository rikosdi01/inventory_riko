import 'package:flutter/material.dart';
import 'package:rikoparts/gudang/gudang.dart';
import 'package:rikoparts/gudang/item.dart';
import 'package:rikoparts/gudang/persamaan.dart';
import 'package:rikoparts/penerimaan/penerimaan.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.red),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SDI 01",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Stok Controller BD",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          ExpansionTile(
            leading: const Icon(Icons.home_filled),
            title: const Text("Gudang"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            initiallyExpanded: isExpanded,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: const Icon(Icons.computer_outlined),
                  title: const Text("Gudang Barang"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const GudangPage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: const Icon(Icons.pallet),
                  title: const Text("Rak Gudang"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Handle item 2 tap
                  },
                ),
              ),
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MyItemPage()));
            },
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Item"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const PenerimaanPage()));
            },
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Penerimaan"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const PersamaanPage()));
            },
            leading: const Icon(Icons.view_compact_alt_rounded),
            title: const Text("Persamaan"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          const SizedBox(
            height: 420,
          ),
          TextButton(
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Log Out"),
                SizedBox(width: 8),
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
