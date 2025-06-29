// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_detail_pemesanan_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetailPemesananResultApi _$DataDetailPemesananResultApiFromJson(
  Map<String, dynamic> json,
) => DataDetailPemesananResultApi(
  json['status'] as String,
  DataDetailPemesananApiData.fromJson(json['result'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataDetailPemesananResultApiToJson(
  DataDetailPemesananResultApi instance,
) => <String, dynamic>{'status': instance.status, 'result': instance.result};
