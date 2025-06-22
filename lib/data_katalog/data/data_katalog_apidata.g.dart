// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_katalog_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataKatalogApiData _$DataKatalogApiDataFromJson(Map<String, dynamic> json) =>
    DataKatalogApiData(
      idProduk: json['id_produk'] as String?,
      namaProduk: json['nama_produk'] as String?,
      idKategori: json['id_kategori'] as String?,
      kategori: json['kategori'] as String?,
      gambar: json['gambar'] as String?,
      harga: json['harga'] as String?,
      jumlah: json['jumlah'] as String?,
      deskripsi: json['deskripsi'] as String?,
      total: json['total'] as String?,
    );

Map<String, dynamic> _$DataKatalogApiDataToJson(DataKatalogApiData instance) =>
    <String, dynamic>{
      'id_produk': instance.idProduk,
      'nama_produk': instance.namaProduk,
      'kategori': instance.kategori,
      'id_kategori': instance.idKategori,
      'gambar': instance.gambar,
      'harga': instance.harga,
      'jumlah': instance.jumlah,
      'deskripsi': instance.deskripsi,
      'total': instance.total,
    };
