// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumApi _$EnumApiFromJson(Map<String, dynamic> json) => EnumApi(
      json['status'] as String,
      (json['result'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EnumApiToJson(EnumApi instance) => <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
