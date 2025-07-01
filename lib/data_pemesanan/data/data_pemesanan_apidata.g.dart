// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pemesanan_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPemesananApiData _$DataPemesananApiDataFromJson(
  Map<String, dynamic> json,
) => DataPemesananApiData(
  idPemesanan: json['id_pemesanan'] as String?,
  tanggalPemesanan: json['tanggal_pemesanan'] as String?,
  idPelanggan: json['id_pelanggan'] as String?,
  idOngkir: json['id_ongkir'] as String?,
  idBank: json['id_bank'] as String?,
  tanggalUploadBuktiPembayaran:
      json['tanggal_upload_bukti_pembayaran'] as String?,
  uploadBuktiPembayaran: json['upload_bukti_pembayaran'] as String?,
  status: json['status'] as String?,
  total: json['total'] as String?,
  ongkir: json['ongkir'] as String?,
  keterangan: json['keterangan'] as String?,
);

Map<String, dynamic> _$DataPemesananApiDataToJson(
  DataPemesananApiData instance,
) => <String, dynamic>{
  'id_pemesanan': instance.idPemesanan,
  'tanggal_pemesanan': instance.tanggalPemesanan,
  'id_pelanggan': instance.idPelanggan,
  'id_ongkir': instance.idOngkir,
  'id_bank': instance.idBank,
  'tanggal_upload_bukti_pembayaran': instance.tanggalUploadBuktiPembayaran,
  'upload_bukti_pembayaran': instance.uploadBuktiPembayaran,
  'status': instance.status,
  'total': instance.total,
  'ongkir': instance.ongkir,
  'keterangan': instance.keterangan,
};
