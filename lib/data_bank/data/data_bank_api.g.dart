// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_bank_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataBankApi _$DataBankApiFromJson(Map<String, dynamic> json) => DataBankApi(
      json['status'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DataBankApiData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataBankApiToJson(DataBankApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
