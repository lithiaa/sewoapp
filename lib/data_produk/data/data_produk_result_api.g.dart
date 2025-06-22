// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_produk_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProdukResultApi _$DataProdukResultApiFromJson(Map<String, dynamic> json) =>
    DataProdukResultApi(
      json['status'] as String,
      DataProdukApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataProdukResultApiToJson(
        DataProdukResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
