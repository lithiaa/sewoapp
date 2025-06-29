import 'package:flutter/material.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';
import 'package:sewoapp/data_katalog/data_katalog_detail.dart';
import 'dart:math'; // Added for Random number generation

class Ekatalog extends StatefulWidget {
  final DataKatalogApiData data;
  final String randomSuffix; // Added random suffix variable

  Ekatalog({super.key, required this.data})
      : randomSuffix = Random().nextInt(999999).toString(); // Initialize random suffix

  @override
  State<Ekatalog> createState() => _EkatalogState();
}

class _EkatalogState extends State<Ekatalog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.48,
      child: Card(
        color: Colors.white, // Background putih
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DataKatalogDetail.routeName,
                arguments: widget.data);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ClipRRect(
                  child: SizedBox(
                    height: 120,
                    width: 150, // Ganti double.infinity dengan nilai fixed width
                    child: Hero(
                      tag: "product_${widget.data.idProduk}_${widget.randomSuffix}",
                      child: Image.network(
                        "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.gambar}",
                        fit: BoxFit.fitWidth, // Gunakan cover sebagai ganti contain
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/image-not-available.jpg",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Text(
                  "${widget.data.kategori}",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Text(
                  "${widget.data.namaProduk}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Harga dipindah ke bawah nama produk
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, bottom: 3, left: 9, right: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Style.buttonBackgroundColor,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: ConfigGlobal.formatRupiah(widget.data.harga),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: "/day",
                          style: TextStyle(
                            color: Colors.grey[300],  // Warna abu-abu muda
                            fontSize: 12,             // Ukuran lebih kecil
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}