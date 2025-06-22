// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pemesanan_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPemesananApi _$DataPemesananApiFromJson(Map<String, dynamic> json) =>
    DataPemesananApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataPemesananApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPemesananApiToJson(DataPemesananApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
