import 'package:flutter/material.dart';

class MySnackBarDelete {
  getSnackBar(BuildContext context) {
    return const SnackBar(
      content: Text('Berhasil dihapus..'),
      duration: Duration(seconds: 3),
    );
  }
}

class MySnackBarAdded {
  getSnackBar(BuildContext context) {
    return const SnackBar(
      content: Text("Berhasil ditambah.."),
      duration: Duration(seconds: 3),
    );
  }
}

class MyScackBarEdit {
  getSnackBar(BuildContext context) {
    return const SnackBar(
      content: Text('Berhasil diubah..'),
      duration: Duration(seconds: 3),
    );
  }
}
