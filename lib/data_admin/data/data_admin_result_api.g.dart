// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_admin_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataAdminResultApi _$DataAdminResultApiFromJson(Map<String, dynamic> json) =>
    DataAdminResultApi(
      json['status'] as String,
      DataAdminApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataAdminResultApiToJson(DataAdminResultApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
