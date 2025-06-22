// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_produk_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProdukApiData _$DataProdukApiDataFromJson(Map<String, dynamic> json) =>
    DataProdukApiData(
      idProduk: json['id_produk'] as String?,
      namaProduk: json['nama_produk'] as String?,
      idKategori: json['id_kategori'] as String?,
      harga: json['harga'] as String?,
      jumlah: json['jumlah'] as String?,
      deskripsi: json['deskripsi'] as String?,
    );

Map<String, dynamic> _$DataProdukApiDataToJson(DataProdukApiData instance) =>
    <String, dynamic>{
      'id_produk': instance.idProduk,
      'nama_produk': instance.namaProduk,
      'id_kategori': instance.idKategori,
      'harga': instance.harga,
      'jumlah': instance.jumlah,
      'deskripsi': instance.deskripsi,
    };
