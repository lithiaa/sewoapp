// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_kategori_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataKategoriResultApi _$DataKategoriResultApiFromJson(
        Map<String, dynamic> json) =>
    DataKategoriResultApi(
      json['status'] as String,
      DataKategoriApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataKategoriResultApiToJson(
        DataKategoriResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
