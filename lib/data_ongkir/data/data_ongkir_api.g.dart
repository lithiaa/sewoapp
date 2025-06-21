// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_ongkir_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataOngkirApi _$DataOngkirApiFromJson(Map<String, dynamic> json) =>
    DataOngkirApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataOngkirApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataOngkirApiToJson(DataOngkirApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
