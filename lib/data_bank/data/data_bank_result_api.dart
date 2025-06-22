import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';

part 'data_bank_result_api.g.dart';

@JsonSerializable()
class DataBankResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataBankApiData result;

  DataBankResultApi(this.status, this.result);

  factory DataBankResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataBankResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataBankResultApiToJson(this);
}

