import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';

part 'data_ongkir_result_api.g.dart';

@JsonSerializable()
class DataOngkirResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataOngkirApiData result;

  DataOngkirResultApi(this.status, this.result);

  factory DataOngkirResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataOngkirResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataOngkirResultApiToJson(this);
}

