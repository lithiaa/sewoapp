import 'package:intl/intl.dart';

class ConfigGlobal {
  static const namaAplikasi = "Aplikasi";
  static const lupaPassword = false;
  static const login = true;
  static const register = true;
  static const baseUrl = "https://sewoapp.lithiaproject.com/sewoapp_website/";
  //static const baseUrl ="https://localhost.scode.web.id/2025-sewo";

  static const jumlahDashboardGrid = 4;

  static String formatRupiah(dynamic number, {int decimalDigit = 0}) {
    if (number == null) return 'Rp 0';
    
    try {
      NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp',
        decimalDigits: decimalDigit,
      );
      
      double value;
      if (number is double) {
        value = number;
      } else if (number is int) {
        value = number.toDouble();
      } else if (number is String) {
        if (number.isEmpty || number == 'null') return 'Rp 0';
        value = double.tryParse(number) ?? 0.0;
      } else {
        value = 0.0;
      }
      
      return currencyFormatter.format(value);
    } catch (e) {
      print('Error formatting currency for value: $number, error: $e');
      return 'Rp 0';
    }
  }



  static String formatTanggal(String? tanggal) {
    if (tanggal == null || tanggal.isEmpty || tanggal == 'null') {
      return 'Date not available';
    }
    
    try {
      DateTime dateTime;
      
      // Try different date formats
      try {
        dateTime = DateFormat("yyyy-MM-dd").parse(tanggal);
      } catch (e) {
        try {
          dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(tanggal);
        } catch (e) {
          dateTime = DateTime.tryParse(tanggal) ?? DateTime.now();
        }
      }

      var m = DateFormat('MM').format(dateTime);
      var d = DateFormat('dd').format(dateTime).toString();
      var Y = DateFormat('yyyy').format(dateTime).toString();
      var month = "";
      switch (m) {
        case '01':
          {
            month = "Januari";
          }
          break;
        case '02':
          {
            month = "Februari";
          }
          break;
        case '03':
          {
            month = "Maret";
          }
          break;
        case '04':
          {
            month = "April";
          }
          break;
        case '05':
          {
            month = "Mei";
          }
          break;
        case '06':
          {
            month = "Juni";
          }
          break;
        case '07':
          {
            month = "Juli";
          }
          break;
        case '08':
          {
            month = "Agustus";
          }
          break;
        case '09':
          {
            month = "September";
          }
          break;
        case '10':
          {
            month = "Oktober";
          }
          break;
        case '11':
          {
            month = "November";
          }
          break;
        case '12':
          {
            month = "Desember";
          }
          break;
      }
      return "$d $month $Y";
    } catch (e) {
      print('Error formatting date for value: $tanggal, error: $e');
      return 'Invalid date';
    }
  }

  static String generateId(String prepend) {
    DateTime now = DateTime.now();
    return prepend + DateFormat('kk:mm:ssdd/MM/yy').format(now);
  }
}
