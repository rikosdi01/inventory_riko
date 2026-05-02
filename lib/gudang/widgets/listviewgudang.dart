import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/provider/gudangprovider.dart';

class ListViewGudang extends StatelessWidget {
  const ListViewGudang({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Gudangprovider>(context);
    prov.sortItemByName();
    prov.sortGudangByName();
    var itemlist = prov.items;

    return ListView.builder(
      itemCount: itemlist.length,
      itemBuilder: (context, index) {
        var currentItem = itemlist[index];
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (currentItem.image !=
                        null) // Check if the image is not null
                      SizedBox(
                        height: 35,
                        child: Center(
                          child: kIsWeb
                              ? Image.network(currentItem.image!.path,
                                  fit: BoxFit.contain) // For Flutter Web
                              : Image.file(currentItem.image!,
                                  fit: BoxFit.contain), // For Flutter Mobile
                        ),
                      )
                    else
                      SizedBox(
                        height: 35,
                        child: Center(
                          child: Text(
                            "No Image",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
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
              title: Text(
                currentItem.item,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(
                currentItem.kode,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${currentItem.totalQty}",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    currentItem.satuan,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item Detail :',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        if (currentItem.image !=
                                            null) // Check if the image is not null
                                          SizedBox(
                                            height: 300,
                                            child: Center(
                                              child: kIsWeb
                                                  ? Image.network(
                                                      currentItem.image!.path,
                                                      fit: BoxFit
                                                          .cover) // For Flutter Web
                                                  : Image.file(
                                                      currentItem.image!,
                                                      fit: BoxFit
                                                          .cover), // For Flutter Mobile
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            height: 300,
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(currentItem.item,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(currentItem.kode,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                            color: Colors.grey[600]),
                                      )),
                                  const SizedBox(height: 30),
                                  Text(
                                      "Total Qty : ${currentItem.totalQty} ${currentItem.satuan}",
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text("Rak Detail : ",
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        if (itemlist[index].rak != null)
                                          for (var gudangitem
                                              in itemlist[index].rak!)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text("${gudangitem.rak} : ",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "${gudangitem.qty} ${currentItem.satuan}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
              }),
        );
      },
    );
  }
}
