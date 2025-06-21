// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_admin_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataAdminApi _$DataAdminApiFromJson(Map<String, dynamic> json) => DataAdminApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataAdminApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataAdminApiToJson(DataAdminApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
