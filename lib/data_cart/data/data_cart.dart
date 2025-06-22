import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';

class DataCart {
  String? idPemesanan = "";
  String? tanggalPemesanan = "";
  String? idPelanggan = "";
  String? idOngkir = "";
  String? idBank = "";
  String? tanggalUploadBuktiPembayaran = "";
  String? uploadBuktiPembayaran = "";
  String? status = "";
  DataDetailPemesanan? detail;

  @JsonKey(ignore: true)
  File? file;

  DataCart({
    this.idPemesanan,
    this.tanggalPemesanan,
    this.idPelanggan,
    this.idOngkir,
    this.idBank,
    this.tanggalUploadBuktiPembayaran,
    this.uploadBuktiPembayaran,
    this.status,
    this.file,
    this.detail,
  });
}
