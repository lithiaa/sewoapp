import 'package:json_annotation/json_annotation.dart';

part 'data_katalog_apidata.g.dart';

@JsonSerializable()
class DataKatalogApiData {
  final String? spesifikasi;

  DataKatalogApiData({
    this.idProduk,
    this.namaProduk,
    this.idKategori,
    this.kategori,
    this.gambar,
    this.harga,
    this.jumlah,
    this.deskripsi,
    this.total,
    this.spesifikasi,
    this.namaPartner,
    this.area,
  });

  @JsonKey(name: "id_produk")
  final String? idProduk;

  @JsonKey(name: "nama_produk")
  final String? namaProduk;

  @JsonKey(name: "kategori")
  final String? kategori;

  @JsonKey(name: "id_kategori")
  final String? idKategori;

  @JsonKey(name: "gambar")
  final String? gambar;

  @JsonKey(name: "harga")
  final String? harga;
  @JsonKey(name: "jumlah")
  final String? jumlah;

  @JsonKey(name: "deskripsi")
  final String? deskripsi;

  @JsonKey(name: "total")
  final String? total;

  @JsonKey(name: "nama_partner")
  final String? namaPartner;

  @JsonKey(name: "area")
  final String? area;

  factory DataKatalogApiData.fromJson(Map<String, dynamic> json) =>
      _$DataKatalogApiDataFromJson(json);



  Map<String, dynamic> toJson() => _$DataKatalogApiDataToJson(this);
}
