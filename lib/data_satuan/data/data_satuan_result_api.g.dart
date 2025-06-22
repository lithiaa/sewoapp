// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_satuan_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSatuanResultApi _$DataSatuanResultApiFromJson(Map<String, dynamic> json) =>
    DataSatuanResultApi(
      json['status'] as String,
      DataSatuanApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataSatuanResultApiToJson(
        DataSatuanResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
