import 'package:flutter/material.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';

const bool showImageCard = false;

class DataPelangganTampilSelect extends StatefulWidget {
  final DataPelangganApiData data;
  const DataPelangganTampilSelect({super.key, required this.data});

  @override
  State<DataPelangganTampilSelect> createState() => _DataPelangganTampilSelectState();
}

class _DataPelangganTampilSelectState extends State<DataPelangganTampilSelect> {
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
            Text(widget.data.idPelanggan ?? '-')
          ],
        ),
      ),
    );
  }
}

