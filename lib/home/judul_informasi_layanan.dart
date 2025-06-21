import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JudulInformasiLayanan extends StatelessWidget {
  const JudulInformasiLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Text(
        "INFORMASI LAYANAN",
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
