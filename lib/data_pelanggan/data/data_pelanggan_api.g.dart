// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pelanggan_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPelangganApi _$DataPelangganApiFromJson(Map<String, dynamic> json) =>
    DataPelangganApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataPelangganApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPelangganApiToJson(DataPelangganApi instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
