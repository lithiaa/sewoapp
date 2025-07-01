// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cart_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCartResultApi _$DataCartResultApiFromJson(Map<String, dynamic> json) =>
    DataCartResultApi(
      json['status'] as String,
      DataCartApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataCartResultApiToJson(DataCartResultApi instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
