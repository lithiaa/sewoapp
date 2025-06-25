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
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(double.parse(number));
  }



  static String formatTanggal(String tanggal) {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(tanggal);

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
  }

  static generateId(String prepend) {
    DateTime now = DateTime.now();
    return prepend + DateFormat('kk:mm:ssdd/MM/yy').format(now);
  }
}
