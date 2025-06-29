// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_kategori_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataKategoriApi _$DataKategoriApiFromJson(Map<String, dynamic> json) =>
    DataKategoriApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataKategoriApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataKategoriApiToJson(DataKategoriApi instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
