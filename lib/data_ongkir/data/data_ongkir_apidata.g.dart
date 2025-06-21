// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_ongkir_apidata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataOngkirApiData _$DataOngkirApiDataFromJson(Map<String, dynamic> json) =>
    DataOngkirApiData(
      idKurir: json['id_ongkir'] as String?,
      kurir: json['kurir'] as String?,
      tujuan: json['tujuan'] as String?,
      biaya: json['biaya'] as String?,
    );

Map<String, dynamic> _$DataOngkirApiDataToJson(DataOngkirApiData instance) =>
    <String, dynamic>{
      'id_ongkir': instance.idKurir,
      'kurir': instance.kurir,
      'tujuan': instance.tujuan,
      'biaya': instance.biaya,
    };
