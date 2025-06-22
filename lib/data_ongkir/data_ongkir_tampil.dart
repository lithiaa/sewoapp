import 'package:flutter/material.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';
import 'package:sewoapp/config/config_global.dart';

const bool showImageCard = false;

class DataOngkirTampil extends StatefulWidget {
  final DataOngkirApiData data;
  final Function(DataOngkirApiData value) onTapEdit;
  final Function(DataOngkirApiData value) onTapHapus;

  const DataOngkirTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataOngkirTampil> createState() => _DataOngkirTampilState();
}

class _DataOngkirTampilState extends State<DataOngkirTampil> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showImageCard)
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.asset(
                  "assets/background.png",
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${widget.data.kurir} (${widget.data.tujuan})",
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /* const Spacer(),
                PopupMenuButton<int>(
                  padding: const EdgeInsets.all(0),
                  onSelected: (item) {
                    if (item == 0) {
                      widget.onTapEdit(widget.data);
                      return;
                    }
                    if (item == 1) {
                      widget.onTapHapus(widget.data);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    const PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                  ],
                ), */
              ],
            ),
            const SizedBox(height: 3),
            Text(
              ConfigGlobal.formatRupiah(widget.data.biaya),
              style: const TextStyle(fontSize: 16),
            ),
/* 
            Text(
              "Keterangan : ${widget.data.keterangan}",
              style: const TextStyle(fontSize: 16),
            ), */
          ],
        ),
      ),
    );
  }
}
