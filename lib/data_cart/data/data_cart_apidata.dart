import 'dart:io';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';

part 'data_cart_apidata.g.dart';

@JsonSerializable()
class DataCartApiData implements DataHapus {
  DataCartApiData({
    this.idPemesanan,
    this.tanggalPemesanan,
    this.idPelanggan,
    this.idOngkir,
    this.idBank,
    this.tanggalUploadBuktiPembayaran,
    this.uploadBuktiPembayaran,
    this.status,
    this.details,
    this.file,
  });

  @JsonKey(ignore: true)
  File? file;

  @JsonKey(name: "id_pemesanan")
  final String? idPemesanan;
  @JsonKey(name: "tanggal_pemesanan")
  final String? tanggalPemesanan;
  @JsonKey(name: "id_pelanggan")
  final String? idPelanggan;
  @JsonKey(name: "id_ongkir")
  final String? idOngkir;
  @JsonKey(name: "id_bank")
  final String? idBank;
  @JsonKey(name: "tanggal_upload_bukti_pembayaran")
  final String? tanggalUploadBuktiPembayaran;
  @JsonKey(name: "upload_bukti_pembayaran")
  final String? uploadBuktiPembayaran;
  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "details")
  final List<DataDetailPemesananApiData>? details;

  factory DataCartApiData.fromJson(Map<String, dynamic> json) =>
      _$DataCartApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataCartApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idPemesanan";
  }

  int totalProduk() {
    if (details == null) {
      return 0;
    }
    if (details!.isEmpty) {
      return 0;
    }
    return details!.map((e) => int.parse(e.jumlah!)).sum;
  }

  int totalHargaProduk() {
    if (details == null) {
      return 0;
    }
    if (details!.isEmpty) {
      return 0;
    }
    return details!.map((e) => int.parse(e.jumlah!) * int.parse(e.harga!)).sum;
  }
}
