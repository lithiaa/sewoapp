import 'package:flutter/material.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_apidata.dart';

const bool showImageCard = false;

class DataPemesananTampilSelect extends StatefulWidget {
  final DataPemesananApiData data;
  const DataPemesananTampilSelect({super.key, required this.data});

  @override
  State<DataPemesananTampilSelect> createState() => _DataPemesananTampilSelectState();
}

class _DataPemesananTampilSelectState extends State<DataPemesananTampilSelect> {
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
                    widget.data.tanggalPemesanan ?? "-",
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                //PopupMenuButton<int>(
                  //onSelected: (item) {},
                  //itemBuilder: (context) => [
                    //const PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    //const PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                  //],
                //),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, widget.data);
                    },
                    icon: const Icon(Icons.arrow_circle_right),
                ),
              ],
            ),
            Text(widget.data.idPemesanan ?? '-')
          ],
        ),
      ),
    );
  }
}

