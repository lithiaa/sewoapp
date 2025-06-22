// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pemesanan_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPemesananResultApi _$DataPemesananResultApiFromJson(
        Map<String, dynamic> json) =>
    DataPemesananResultApi(
      json['status'] as String,
      DataPemesananApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataPemesananResultApiToJson(
        DataPemesananResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
