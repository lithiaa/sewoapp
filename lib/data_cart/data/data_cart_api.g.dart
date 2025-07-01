// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cart_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCartApi _$DataCartApiFromJson(Map<String, dynamic> json) => DataCartApi(
  json['status'] as String,
  (json['result'] as List<dynamic>)
      .map((e) => DataCartApiData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataCartApiToJson(DataCartApi instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
