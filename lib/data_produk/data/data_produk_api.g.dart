// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_produk_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProdukApi _$DataProdukApiFromJson(Map<String, dynamic> json) =>
    DataProdukApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataProdukApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataProdukApiToJson(DataProdukApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
