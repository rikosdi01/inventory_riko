import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/arsip/iteminfo2.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class MyCardView extends StatefulWidget {
  const MyCardView({super.key});

  @override
  State<MyCardView> createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardView> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var itemlist = prov.items;

    prov.sortItemByName();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.start,
          children: itemlist.map((currentItem) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  int currentIndex = itemlist
                      .indexWhere((item) => item.item == currentItem.item);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemInfoPage(index: currentIndex),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500]!),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    width: 300,
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (currentItem.image !=
                                  null) // Check if the image is not null
                                SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: kIsWeb
                                        ? Image.network(currentItem.image!.path,
                                            fit: BoxFit
                                                .contain) // For Flutter Web
                                        : Image.file(currentItem.image!,
                                            fit: BoxFit
                                                .contain), // For Flutter Mobile
                                  ),
                                )
                              else
                                SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      "No Image",
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              // ... (other widgets in your Card)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          currentItem.item,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          currentItem.kode,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rp. ${currentItem.harga} / ${currentItem.isi} ${currentItem.satuan}",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
