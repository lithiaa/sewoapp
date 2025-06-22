import 'package:flutter/material.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';

const bool showImageCard = false;

class DataOngkirTampilSelect extends StatefulWidget {
  final DataOngkirApiData data;
  const DataOngkirTampilSelect({super.key, required this.data});

  @override
  State<DataOngkirTampilSelect> createState() => _DataOngkirTampilSelectState();
}

class _DataOngkirTampilSelectState extends State<DataOngkirTampilSelect> {
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
                Expanded(
                  child: Text(
                    "${widget.data.kurir} (${widget.data.tujuan})",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, widget.data);
                  },
                  icon: const Icon(Icons.arrow_circle_right),
                ),
              ],
            ),
            Text(ConfigGlobal.formatRupiah(widget.data.biaya))
          ],
        ),
      ),
    );
  }
}
