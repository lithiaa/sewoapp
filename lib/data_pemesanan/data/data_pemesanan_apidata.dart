import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_pemesanan_apidata.g.dart';

@JsonSerializable()
class DataPemesananApiData implements DataHapus {
  DataPemesananApiData({
    this.idPemesanan,
    this.tanggalPemesanan,
    this.idPelanggan,
    this.idOngkir,
    this.idBank,
    this.tanggalUploadBuktiPembayaran,
    this.uploadBuktiPembayaran,
    this.status,
    this.total,
    this.ongkir,
    this.keterangan,
  });

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

  @JsonKey(name: "total")
  final String? total;

  @JsonKey(name: "ongkir")
  final String? ongkir;

  @JsonKey(name: "keterangan")
  final String? keterangan;

  factory DataPemesananApiData.fromJson(Map<String, dynamic> json) =>
      _$DataPemesananApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataPemesananApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idPemesanan";
  }

  int grandTotal() {
    return int.parse(total ?? "0") + int.parse(ongkir ?? "0");
  }
}
