import 'package:flutter/material.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';
import 'package:sewoapp/config/config_global.dart';

const bool showImageCard = true;

class DataBankTampil extends StatefulWidget {
  final DataBankApiData data;
  final Function(DataBankApiData value) onTapEdit;
  final Function(DataBankApiData value) onTapHapus;

  const DataBankTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataBankTampil> createState() => _DataBankTampilState();
}

class _DataBankTampilState extends State<DataBankTampil> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${widget.data.namaBank}",
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              "${widget.data.namaPemilik}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "${widget.data.rekening}",
              style: const TextStyle(fontSize: 16),
            ),
            if (showImageCard)
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.fotoLogoBank}",
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image load failed: $error'); // Debug print
                    return Image.asset(
                      "assets/image-not-available.jpg",
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
