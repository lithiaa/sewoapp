// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_ongkir_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataOngkirResultApi _$DataOngkirResultApiFromJson(Map<String, dynamic> json) =>
    DataOngkirResultApi(
      json['status'] as String,
      DataOngkirApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataOngkirResultApiToJson(
  DataOngkirResultApi instance,
) => <String, dynamic>{'status': instance.status, 'result': instance.result};
