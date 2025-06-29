// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_bank_result_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataBankResultApi _$DataBankResultApiFromJson(Map<String, dynamic> json) =>
    DataBankResultApi(
      json['status'] as String,
      DataBankApiData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataBankResultApiToJson(DataBankResultApi instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
