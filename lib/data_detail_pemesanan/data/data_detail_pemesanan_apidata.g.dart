// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_detail_pemesanan_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetailPemesananApiData _$DataDetailPemesananApiDataFromJson(
        Map<String, dynamic> json) =>
    DataDetailPemesananApiData(
      idDetailPemesanan: json['id_detail_pemesanan'] as String?,
      idPemesanan: json['id_pemesanan'] as String?,
      idProduk: json['id_produk'] as String?,
      jumlah: json['jumlah'] as String?,
      harga: json['harga'] as String?,
      namaProduk: json['nama_produk'] as String?,
      gambar: json['gambar'] as String?,
    );

Map<String, dynamic> _$DataDetailPemesananApiDataToJson(
        DataDetailPemesananApiData instance) =>
    <String, dynamic>{
      'nama_produk': instance.namaProduk,
      'gambar': instance.gambar,
      'id_detail_pemesanan': instance.idDetailPemesanan,
      'id_pemesanan': instance.idPemesanan,
      'id_produk': instance.idProduk,
      'jumlah': instance.jumlah,
      'harga': instance.harga,
    };
