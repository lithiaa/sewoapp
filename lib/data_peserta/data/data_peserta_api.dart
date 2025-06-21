import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_apidata.dart';

part 'data_peserta_api.g.dart';

@JsonSerializable()
class DataPesertaApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataPesertaApiData> result;

  DataPesertaApi(this.status, this.result);


  factory DataPesertaApi.fromJson(Map<String, dynamic> json) =>
      _$DataPesertaApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPesertaApiToJson(this);
}
