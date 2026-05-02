import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rikoparts/penerimaan/isipenerimaan.dart';
import 'package:rikoparts/provider/penerimaanprovider.dart';

class ListViewPenerimaan extends StatelessWidget {
  const ListViewPenerimaan({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<PenerimaanProvider>(context);
    var penerimaanlist = prov.semuapenerimaan;
    return ListView.builder(
      itemCount: penerimaanlist.length,
      itemBuilder: (context, index) {
        var currentpenerimaan = penerimaanlist[index];
        String formattedTanggal =
            DateFormat('dd-MM-yyyy').format(currentpenerimaan.tanggal);
        return GestureDetector(
          onTap: () {
            // Pass the selected vendor data to IsiPenerimaaPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IsiPenerimaanPage(index: index)
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: ListTile(
              leading: Text(formattedTanggal,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              title: Text(currentpenerimaan.vendor,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              subtitle: Text(currentpenerimaan.deskripsi,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              trailing: Text(currentpenerimaan.kode,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
