import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/widgets/dialogdelete.dart';

import '../../provider/gudangprovider.dart';

class ListViewRakDepotInfo extends StatelessWidget {
  const ListViewRakDepotInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var rakDepot = prov.rakdepotinfo;
    var dialog = MyDialogDepot();
    prov.sortRakDepotByName();
    return ListView.builder(
      itemCount: prov.rakdepotinfo.length,
      itemBuilder: ((context, index) {
        var currentRak = rakDepot[index];
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: ListTile(
            title: Text(currentRak.rakDepot),
            subtitle: Text(currentRak.lokasiDepot),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => dialog.getDialog(context, index));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Rak Detail"),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Divider(),
                            Text(
                              currentRak.rakDepot,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currentRak.lokasiDepot,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              "Item : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Item"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Qty"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // prov.addGudang(rakcontroller.text);
                              Navigator.pop(context);
                            },
                            child: const Text('Tutup'),
                          ),
                        ],
                      ));
            },
          ),
        );
      }),
    );
  }
}
