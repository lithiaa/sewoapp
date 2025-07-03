import 'package:flutter/material.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';
import 'package:sewoapp/data_katalog/data_katalog_detail.dart';

class DataKatalogTampil extends StatefulWidget {
  DataKatalogApiData data;
  DataKatalogTampil({super.key, required this.data});

  @override
  State<DataKatalogTampil> createState() => _DataKatalogTampilState();
}

class _DataKatalogTampilState extends State<DataKatalogTampil> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            DataKatalogDetail.routeName,
            arguments: widget.data,
          );
        },
        child: Card(
          color: const Color(0xFFF2F6FF), // Card color
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10), // Margin only left and right
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Card radius
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjusted padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                  Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Top-left alignment
                  children: [
                    const Icon(
                      Icons.store, // Placeholder icon
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.data.namaPartner ?? 'Unknown Partner',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Area/Location below partner name
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue.withOpacity(0.1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 10,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.data.area ?? 'Lokasi tidak tersedia',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Hero(
                  tag: "${widget.data.namaProduk}",
                  child: Image.network(
                    "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.gambar}",
                    width: width, // Full width
                    height: width * 0.3, // Reduced height for smaller card
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/image-not-available.jpg",
                        width: width,
                        height: width * 0.3,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.data.namaProduk}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${widget.data.kategori}",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              ConfigGlobal.formatRupiah(widget.data.harga),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Style.buttonBackgroundColor,
                              ),
                            ),
                            const Text(
                              "/day",
                              style: TextStyle(
                                fontSize: 14,
                                color: Style.buttonBackgroundColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Rating below price
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            const Text(
                              '4.0',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}