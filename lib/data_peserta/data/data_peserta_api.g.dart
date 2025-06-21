// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_peserta_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPesertaApi _$DataPesertaApiFromJson(Map<String, dynamic> json) =>
    DataPesertaApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataPesertaApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPesertaApiToJson(DataPesertaApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
