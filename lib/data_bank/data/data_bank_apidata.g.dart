// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_bank_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataBankApiData _$DataBankApiDataFromJson(Map<String, dynamic> json) =>
    DataBankApiData(
      idBank: json['id_bank'] as String?,
      namaBank: json['nama_bank'] as String?,
      namaPemilik: json['nama_pemilik'] as String?,
      rekening: json['rekening'] as String?,
      fotoLogoBank: json['foto_logo_bank'] as String?,
    );

Map<String, dynamic> _$DataBankApiDataToJson(DataBankApiData instance) =>
    <String, dynamic>{
      'id_bank': instance.idBank,
      'nama_bank': instance.namaBank,
      'nama_pemilik': instance.namaPemilik,
      'rekening': instance.rekening,
      'foto_logo_bank': instance.fotoLogoBank,
    };
