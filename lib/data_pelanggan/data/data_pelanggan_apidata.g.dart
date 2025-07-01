// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pelanggan_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPelangganApiData _$DataPelangganApiDataFromJson(
  Map<String, dynamic> json,
) => DataPelangganApiData(
  idPelanggan: json['id_pelanggan'] as String?,
  nama: json['nama'] as String?,
  alamat: json['alamat'] as String?,
  noTelepon: json['no_telepon'] as String?,
  email: json['email'] as String?,
  username: json['username'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$DataPelangganApiDataToJson(
  DataPelangganApiData instance,
) => <String, dynamic>{
  'id_pelanggan': instance.idPelanggan,
  'nama': instance.nama,
  'alamat': instance.alamat,
  'no_telepon': instance.noTelepon,
  'email': instance.email,
  'username': instance.username,
  'password': instance.password,
};
