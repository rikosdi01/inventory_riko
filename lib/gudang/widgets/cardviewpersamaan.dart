import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class MyCardViewPersamaan extends StatefulWidget {
  const MyCardViewPersamaan({super.key});

  @override
  State<MyCardViewPersamaan> createState() => _MyCardViewPersamaanState();
}

class _MyCardViewPersamaanState extends State<MyCardViewPersamaan> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    var persamaanlist = prov.itempersamaan;

    return ListView.builder(
      itemCount: persamaanlist.length,
      itemBuilder: (context, index) {
        var currentPersamaan = persamaanlist[index];
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[500]!, width: 2),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kategori : ${currentPersamaan.kategori}",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.start,
                      children: List.generate(currentPersamaan.item.length,
                          (itemIndex) {
                        var currentImage = currentPersamaan.image![itemIndex];
                        var currentItem = currentPersamaan.item[itemIndex];
                        var currentKeterangan =
                            currentPersamaan.keterangan[itemIndex];
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  width: 250,
                                  height: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (currentImage !=
                                                  null) // Check if the image is not null
                                                SizedBox(
                                                  height: 200,
                                                  child: Center(
                                                    child: kIsWeb
                                                        ? Image.network(
                                                            currentImage.path,
                                                            fit: BoxFit
                                                                .contain) // For Flutter Web
                                                        : Image.file(
                                                            currentImage,
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
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              // ... (other widgets in your Card)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                            child: Text(currentItem,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                )),
                                                textAlign: TextAlign.center)),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0)),
                                width: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Keterangan : ",
                                          style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        currentKeterangan,
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
