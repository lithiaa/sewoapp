import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_detail_pemesanan_apidata.g.dart';

// Helper function to convert numeric values to strings
String? _convertToString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

@JsonSerializable()
class DataDetailPemesananApiData implements DataHapus {
  DataDetailPemesananApiData({
    this.idDetailPemesanan,
    this.idPemesanan,
    this.idProduk,
    this.jumlah,
    this.harga,
    this.namaProduk,
    this.gambar,
    this.namaPartner,
  });

  @JsonKey(name: "nama_produk")
  final String? namaProduk;

  @JsonKey(name: "gambar")
  final String? gambar;

  @JsonKey(name: "nama_partner")
  final String? namaPartner;

  @JsonKey(name: "id_detail_pemesanan")
  final String? idDetailPemesanan;
  @JsonKey(name: "id_pemesanan")
  final String? idPemesanan;
  @JsonKey(name: "id_produk")
  final String? idProduk;
  @JsonKey(name: "jumlah", fromJson: _convertToString)
  final String? jumlah;
  @JsonKey(name: "harga", fromJson: _convertToString)
  final String? harga;

  factory DataDetailPemesananApiData.fromJson(Map<String, dynamic> json) =>
      _$DataDetailPemesananApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailPemesananApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idDetailPemesanan";
  }
}
