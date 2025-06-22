import 'package:flutter/material.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_apidata.dart';

const bool showImageCard = true;

class DataPesertaTampil extends StatefulWidget {
  final DataPesertaApiData data;
  const DataPesertaTampil({super.key, required this.data});

  @override
  State<DataPesertaTampil> createState() => _DataPesertaTampilState();
}

class _DataPesertaTampilState extends State<DataPesertaTampil> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
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
                SizedBox(
                  width: _width - 120,
                  child: Text(
                    widget.data.nama ?? "-",
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                PopupMenuButton<int>(
                  onSelected: (item) {},
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    const PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                  ],
                ),
              ],
            ),
            Text(widget.data.idPeserta ?? '-')
          ],
        ),
      ),
    );
  }
}

