import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';

class JudulEkatalog extends StatefulWidget {
  final String judul;
  const JudulEkatalog({super.key, required this.judul});

  @override
  State<JudulEkatalog> createState() => _JudulEkatalogState();
}

class _JudulEkatalogState extends State<JudulEkatalog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.judul,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            /* Text(
              "Informasi Produk Terbaru",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), */
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
          },
          child: Row(children: [
            Text(
              "All Product",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_right, color: Colors.blue[600]),
          ]),
        )
      ]),
    );
  }
}
