import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_produk_apidata.g.dart';

@JsonSerializable()
class DataProdukApiData implements DataHapus {
  DataProdukApiData({
    this.idProduk,
    this.namaProduk,
    this.idKategori,
    this.harga,
    this.jumlah,
    this.deskripsi,
  });

  @JsonKey(name: "id_produk")
  final String? idProduk;
  @JsonKey(name: "nama_produk")
  final String? namaProduk;
  @JsonKey(name: "id_kategori")
  final String? idKategori;
  @JsonKey(name: "harga")
  final String? harga;
  @JsonKey(name: "jumlah")
  final String? jumlah;
  @JsonKey(name: "deskripsi")
  final String? deskripsi;

  factory DataProdukApiData.fromJson(Map<String, dynamic> json) =>
      _$DataProdukApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataProdukApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idProduk";
  }
}
