import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/widgets/dialogdelete.dart';

import '../../provider/gudangprovider.dart';

class ListViewRakF7Info extends StatelessWidget {
  const ListViewRakF7Info({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var rakF7 = prov.rakf7info;
    var dialog = MyDialogF7();
    prov.sortRakF7ByName();
    return ListView.builder(
      itemCount: prov.rakf7info.length,
      itemBuilder: ((context, index) {
        var currentRak = rakF7[index];
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: ListTile(
            title: Text(currentRak.rakF7),
            subtitle: Text(currentRak.lokasiF7),
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
                              currentRak.rakF7,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currentRak.lokasiF7,
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
