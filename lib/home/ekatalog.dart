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
      width: width * 0.5,
      child: Card(
        color: Colors.white, // Background putih
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DataKatalogDetail.routeName,
                arguments: widget.data);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 6, right: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Hero(
                      tag: "product_${widget.data.idProduk}_${widget.randomSuffix}",
                      child: Image.network(
                        "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.gambar}",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Text(
                  "${widget.data.kategori}",
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                child: Text(
                  "${widget.data.namaProduk}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Rating Section (Dummy)
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(5, (index) {
                      // Generate dummy rating between 3.0 - 5.0
                      int itemId = widget.data.idProduk?.hashCode ?? 0;
                      double rating = 3.0 + (itemId % 20) / 10.0; // Rating 3.0-5.0
                      int fullStars = rating.floor();
                      bool hasHalfStar = (rating - fullStars) >= 0.5;
                      
                      if (index < fullStars) {
                        return Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        );
                      } else if (index == fullStars && hasHalfStar) {
                        return Icon(
                          Icons.star_half,
                          size: 12,
                          color: Colors.amber,
                        );
                      } else {
                        return Icon(
                          Icons.star_border,
                          size: 12,
                          color: Colors.grey[400],
                        );
                      }
                    }),
                    const SizedBox(width: 3),
                    Text(
                      "${(3.0 + ((widget.data.idProduk?.hashCode ?? 0) % 20) / 10.0).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Harga dipindah ke bawah rating
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                            fontSize: 13,
                          ),
                        ),
                        TextSpan(
                          text: "/day",
                          style: TextStyle(
                            color: Colors.grey[300],  // Warna abu-abu muda
                            fontSize: 10,             // Ukuran lebih kecil
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