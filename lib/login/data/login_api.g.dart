// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginApi _$LoginApiFromJson(Map<String, dynamic> json) => LoginApi(
      json['status'] as String,
      json['pesan'] as String?,
      json['result'] == null
          ? null
          : LoginApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginApiToJson(LoginApi instance) => <String, dynamic>{
      'status': instance.status,
      'pesan': instance.pesan,
      'result': instance.result,
    };
