// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_satuan_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSatuanApi _$DataSatuanApiFromJson(Map<String, dynamic> json) =>
    DataSatuanApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataSatuanApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataSatuanApiToJson(DataSatuanApi instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
