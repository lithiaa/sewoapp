import 'package:flutter/material.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_apidata.dart';
import 'package:sewoapp/config/config_global.dart';
import 'dart:convert'; // For JSON parsing

class DataPemesananTampil extends StatefulWidget {
  final DataPemesananApiData data;
  final Function(DataPemesananApiData value) onTapEdit;
  final Function(DataPemesananApiData value) onTapHapus;

  const DataPemesananTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataPemesananTampil> createState() => _DataPemesananTampilState();
}

class _DataPemesananTampilState extends State<DataPemesananTampil> {
  // Safe format rupiah to handle null values
  String _safeFormatRupiah(dynamic value) {
    if (value == null) return 'Rp 0';
    if (value is String && (value.isEmpty || value == 'null')) return 'Rp 0';
    if (value is num && value == 0) return 'Rp 0';
    
    try {
      return ConfigGlobal.formatRupiah(value.toString());
    } catch (e) {
      print('Error formatting rupiah for value: $value, error: $e');
      return 'Rp 0';
    }
  }

  // Safe get integer value
  int _safeGetInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      if (value.isEmpty || value == 'null') return 0;
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  // Safe get string value
  String _safeGetString(dynamic value) {
    if (value == null) return '-';
    if (value is String && (value.isEmpty || value == 'null')) return '-';
    return value.toString();
  }

  // Parse the keterangan JSON field into a Map
  Map<String, dynamic> parseKeterangan() {
    try {
      if (widget.data.keterangan != null && widget.data.keterangan!.isNotEmpty) {
        return jsonDecode(widget.data.keterangan!) as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error parsing keterangan: $e');
    }

    // Default values if parsing fails or keterangan is empty
    return {
      'vehicle': {
        'name': '-',
        'license_plate': '-'
      },
      'duration': 0,
      'duration_unit': 'days',
      'rental_fee': 0,
      'retrieval': "",
      'return': "",
      'rental_fee_unit': 'per_day',
      'payment_method': '-',
      'grand_total': 0
    };
  }

  // Calculate return day based on tanggalPemesanan and duration
  String getReturnDay() {
    final details = parseKeterangan();
    final dateTime = widget.data.tanggalPemesanan != null
        ? DateTime.tryParse(widget.data.tanggalPemesanan!) ?? DateTime.now()
        : DateTime.now();
    final duration = _safeGetInt(details['duration']);
    final returnDate = dateTime.add(Duration(days: duration));
    return ConfigGlobal.formatTanggal(returnDate.toString().split(' ')[0]); // Extract date part only
  }

  @override
  Widget build(BuildContext context) {
    final details = parseKeterangan();
    final vehicle = details['vehicle'] as Map<String, dynamic>;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${widget.data.idPemesanan?.padLeft(6, '0') ?? '#000000'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            _buildDetailRow_nosymbol(
              _safeGetString(vehicle['name']),
              ConfigGlobal.formatTanggal((widget.data.tanggalPemesanan ?? DateTime.now().toString()).split(' ')[0]),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'ORDER DETAIL',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildDetailRow('Vehicle', _safeGetString(vehicle['name'])),
                _buildDetailRow('Rental Duration', '${_safeGetInt(details['duration'])} ${_safeGetString(details['duration_unit'])}'),
                _buildDetailRow(
                  'Rental Fee',
                  '${_safeFormatRupiah(details['rental_fee'])}/${_safeGetString(details['rental_fee_unit']).replaceAll('_', ' ')}',
                ),
                _buildDetailRow('Select Retrieval', _safeGetString(details['retrieval'])),
                _buildDetailRow('Return Day', _safeGetString(details['return'])),
                const SizedBox(height: 16),
                const Text(
                  'PICKUP INFORMATION',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 1),
                _buildDetailRow('Due', '2025-01-01'), // Placeholder for due date,
                _buildDetailRow('Location', 'Jl. Kesumba No.7 RT.4 RW.2, Kec. Cakung, Jakarta Timur'), // Placeholder for location
                _buildDetailRow('Contact Person', '0888088882'), // Placeholder for contact person
                const SizedBox(height: 16),
                const Text(
                  'PAYMENT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 1),
                _buildDetailRow('Payment Method', _safeGetString(details['payment_method'])),
                _buildDetailRow(
                  'Total Bill',
                  _safeFormatRupiah(details['grand_total']),
                  isBold: true,
                  isLarge: true,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Upload Payment Receipt',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: Image.network(
                      "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.uploadBuktiPembayaran}",
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('No receipt available');
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      ConfigGlobal.formatTanggal((widget.data.tanggalPemesanan ?? DateTime.now().toString()).split(' ')[0]),
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 6),
                Chip(
                  label: Text(
                    widget.data.status?.toUpperCase() ?? 'PENDING',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getStatusColor(widget.data.status),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow_nosymbol(String label, String value, {bool isBold = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isLarge ? 16 : 14,
                color: isLarge ? Theme.of(context).primaryColor : Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: Colors.grey[700],
              ),
            ),
          ),
          const Text(':'),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isLarge ? 16 : 14,
                color: isLarge ? Theme.of(context).primaryColor : Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'proses':
        return Colors.orange;
      case 'bukti ditolak':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class DetailImage extends StatelessWidget {
  final String imageUrl;

  const DetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}