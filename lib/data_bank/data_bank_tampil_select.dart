import 'package:flutter/material.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';

const bool showImageCard = false;

class DataBankTampilSelect extends StatefulWidget {
  final DataBankApiData data;
  const DataBankTampilSelect({super.key, required this.data});

  @override
  State<DataBankTampilSelect> createState() => _DataBankTampilSelectState();
}

class _DataBankTampilSelectState extends State<DataBankTampilSelect> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                /* if (showImageCard)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.fotoLogoBank}",
                    ),
                  ), */
                Text(
                  "${widget.data.namaBank}",
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.data.namaPemilik}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(widget.data.rekening ?? '-'),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context, widget.data);
              },
              icon: const Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
    );
  }
}
