// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_peserta_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPesertaResultApi _$DataPesertaResultApiFromJson(
        Map<String, dynamic> json) =>
    DataPesertaResultApi(
      json['status'] as String,
      json['result'] == null
          ? null
          : DataPesertaApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataPesertaResultApiToJson(
        DataPesertaResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
