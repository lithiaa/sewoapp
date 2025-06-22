// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pelanggan_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPelangganResultApi _$DataPelangganResultApiFromJson(
        Map<String, dynamic> json) =>
    DataPelangganResultApi(
      json['status'] as String,
      DataPelangganApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataPelangganResultApiToJson(
        DataPelangganResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
