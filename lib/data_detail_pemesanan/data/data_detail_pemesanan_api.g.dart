// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_detail_pemesanan_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetailPemesananApi _$DataDetailPemesananApiFromJson(
  Map<String, dynamic> json,
) => DataDetailPemesananApi(
  json['status'] as String,
  (json['result'] as List<dynamic>)
      .map(
        (e) => DataDetailPemesananApiData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$DataDetailPemesananApiToJson(
  DataDetailPemesananApi instance,
) => <String, dynamic>{'status': instance.status, 'result': instance.result};
