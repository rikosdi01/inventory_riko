import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/gudang/item.dart';
import 'package:rikoparts/provider/gudangprovider.dart';
import 'package:rikoparts/provider/penerimaanprovider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Gudangprovider()),
      ChangeNotifierProvider(create: (_) => PenerimaanProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const MyItemPage(),
    );
  }
}
