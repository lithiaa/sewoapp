import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';

part 'data_bank_api.g.dart';

@JsonSerializable()
class DataBankApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataBankApiData> result;

  DataBankApi(this.status, this.result);


  factory DataBankApi.fromJson(Map<String, dynamic> json) =>
      _$DataBankApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataBankApiToJson(this);
}
