import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';

const bool showImageCard = true;

class DataCartTampil extends StatefulWidget {
  final DataDetailPemesananApiData data;
  final Function(DataDetailPemesananApiData value) onTapEdit;
  final Function(DataDetailPemesananApiData value) onTapHapus;

  const DataCartTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataCartTampil> createState() => _DataCartTampilState();
}

class _DataCartTampilState extends State<DataCartTampil> {
  String _jumlah = '1';
  DateTime? _retrievalDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _jumlah = (int.tryParse(widget.data.jumlah ?? '1') ?? 1).toString();
    _retrievalDate = DateTime.now();
  }

  String get _returnDate {
    if (_retrievalDate == null) return '-';
    final days = int.tryParse(_jumlah) ?? 1;
    final returnDate = _retrievalDate!.add(Duration(days: days));
    return _dateFormat.format(returnDate);
  }

  Future<void> _selectRetrievalDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _retrievalDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _retrievalDate) {
      setState(() {
        _retrievalDate = picked;
      });

      await ConfigSessionManager.getInstance().saveRetrievalDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.store, // Placeholder icon
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Sinagra Rentals',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Space between the icon/text and the image
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showImageCard)
                      Image.network(
                        "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.gambar}",
                        height: 100,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/image-not-available.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.data.namaProduk}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: ConfigGlobal.formatRupiah(widget.data.harga),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: "/day",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Retrieval and Return Day",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Divider(thickness: 1, color: Colors.grey[300]),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Day:",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const Spacer(),
                    NumericStepButton(
                      value: int.tryParse(_jumlah) ?? 1,
                      minValue: 1,
                      onChanged: (value) {
                        if (value < 1) {
                          showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Batalkan Checkout ?'),
                              content: const Text(
                                  'Jumlah hari kurang dari 1. Apakah Anda ingin membatalkan Checkout ?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('ya'),
                                ),
                              ],
                            ),
                          ).then((confirm) {
                            if (confirm == true) {
                              widget.onTapHapus(widget.data);
                            }
                          });
                        } else {
                          setState(() {
                            _jumlah = value.toString();
                          });
                          widget.onTapEdit(
                            DataDetailPemesananApiData(
                              idProduk: widget.data.idProduk,
                              namaProduk: widget.data.namaProduk,
                              jumlah: value.toString(),
                              harga: widget.data.harga,
                              gambar: widget.data.gambar,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 9),
                    Container(
                      margin: const EdgeInsets.only(left: 9),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text('Apakah akan membatalkan checkout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Ya'),
                                ),
                              ],
                            ),
                          ).then((confirm) {
                            if (confirm == true) {
                              print('Delete icon tapped for product: ${widget.data.idProduk}');
                              widget.onTapHapus(widget.data);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Retrieval:",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: _retrievalDate == null
                              ? 'Pilih tanggal'
                              : _dateFormat.format(_retrievalDate!),
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        onTap: _selectRetrievalDate,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Return:",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: _returnDate,
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NumericStepButton extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumericStepButton({
    Key? key,
    this.value = 1,
    this.minValue = 1,
    this.maxValue = 50,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NumericStepButton> createState() => _NumericStepButtonState();
}

class _NumericStepButtonState extends State<NumericStepButton> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Style.buttonBackgroundColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3),
          iconSize: 32.0,
          onPressed: () {
            setState(() {
              if (counter <= widget.minValue) {
                widget.onChanged(counter - 1); // Trigger alert for < 1
              } else {
                counter--;
                widget.onChanged(counter);
              }
            });
          },
        ),
        Text(
          '$counter',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Style.buttonBackgroundColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3),
          iconSize: 32.0,
          onPressed: () {
            setState(() {
              if (counter < widget.maxValue) {
                counter++;
                widget.onChanged(counter);
              }
            });
          },
        ),
      ],
    );
  }
}