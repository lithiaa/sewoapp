import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class JudulEPromotioan extends StatefulWidget {
  final String judul;
  const JudulEPromotioan({super.key, required this.judul});

  @override
  State<JudulEPromotioan> createState() => _JudulEPromotioanState();
}

class _JudulEPromotioanState extends State<JudulEPromotioan> {
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
                  color: Colors.black,
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

      ]),
    );
  }
}
