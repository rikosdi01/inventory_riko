import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/item.dart';
import 'package:rikoparts/gudang/widgets/snackbar.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class MyDialogItems {
  getDialog(BuildContext context, int index) {
    var prov = Provider.of<Gudangprovider>(context);
    var snackbardelete = MySnackBarDelete();
    return AlertDialog(
      title: Text('Hapus Item ${prov.items[index].item}'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal')),
        TextButton(
            onPressed: () {
              prov.removeItems(index);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MyItemPage()));
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackbardelete.getSnackBar(context));
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}

class MyDialogGudang {
  getDialog(BuildContext context, int index) {
    var prov = Provider.of<Gudangprovider>(context);
    var snackbardelete = MySnackBarDelete();
    return AlertDialog(
      title: Text('Hapus Gudang ${prov.tambahgudang[index].rak}'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal')),
        TextButton(
            onPressed: () {
              prov.removeRakGudang(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackbardelete.getSnackBar(context));
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}

class MyDialogDepot {
  getDialog(BuildContext context, int index) {
    var prov = Provider.of<Gudangprovider>(context);
    var snackbardelete = MySnackBarDelete();
    return AlertDialog(
      title: Text('Hapus rak ${prov.rakdepotinfo[index].rakDepot}?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal')),
        TextButton(
            onPressed: () {
              prov.removeRakDepot(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackbardelete.getSnackBar(context));
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}

class MyDialogF7 {
  getDialog(BuildContext context, int index) {
    var prov = Provider.of<Gudangprovider>(context);
    var snackbardelete = MySnackBarDelete();
    return AlertDialog(
      title: Text('Hapus rak ${prov.rakf7info[index].rakF7}?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal')),
        TextButton(
            onPressed: () {
              prov.removeRakF7(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackbardelete.getSnackBar(context));
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}
