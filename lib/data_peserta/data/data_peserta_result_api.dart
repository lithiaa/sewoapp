import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_apidata.dart';

part 'data_peserta_result_api.g.dart';

@JsonSerializable()
class DataPesertaResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  DataPesertaApiData? result;

  DataPesertaResultApi(this.status, this.result);

  factory DataPesertaResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataPesertaResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPesertaResultApiToJson(this);
}

