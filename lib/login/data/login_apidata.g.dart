// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginApiData _$LoginApiDataFromJson(Map<String, dynamic> json) => LoginApiData(
      id: json['id'] as String?,
      jabatan: json['jabatan'] as String?,
      namaPegawai: json['nama_pegawai'] as String?,
      tkn: json['tkn'] as String?,
    );

Map<String, dynamic> _$LoginApiDataToJson(LoginApiData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jabatan': instance.jabatan,
      'nama_pegawai': instance.namaPegawai,
      'tkn': instance.tkn,
    };
