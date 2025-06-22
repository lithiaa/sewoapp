import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_detail_pemesanan_apidata.g.dart';

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
  });

  @JsonKey(name: "nama_produk")
  final String? namaProduk;

  @JsonKey(name: "gambar")
  final String? gambar;

  @JsonKey(name: "id_detail_pemesanan")
  final String? idDetailPemesanan;
  @JsonKey(name: "id_pemesanan")
  final String? idPemesanan;
  @JsonKey(name: "id_produk")
  final String? idProduk;
  @JsonKey(name: "jumlah")
  final String? jumlah;
  @JsonKey(name: "harga")
  final String? harga;

  factory DataDetailPemesananApiData.fromJson(Map<String, dynamic> json) =>
      _$DataDetailPemesananApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailPemesananApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idDetailPemesanan";
  }
}
