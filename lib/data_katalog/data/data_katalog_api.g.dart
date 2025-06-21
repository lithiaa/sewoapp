// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_katalog_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataKatalogApi _$DataKatalogApiFromJson(Map<String, dynamic> json) =>
    DataKatalogApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataKatalogApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataKatalogApiToJson(DataKatalogApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
