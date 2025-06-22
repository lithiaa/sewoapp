// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterApi _$RegisterApiFromJson(Map<String, dynamic> json) => RegisterApi(
      json['status'] as String,
      json['pesan'] as String?,
    );

Map<String, dynamic> _$RegisterApiToJson(RegisterApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pesan': instance.pesan,
    };
