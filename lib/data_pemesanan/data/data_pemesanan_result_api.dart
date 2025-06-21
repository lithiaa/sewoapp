import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_apidata.dart';

part 'data_pemesanan_result_api.g.dart';

@JsonSerializable()
class DataPemesananResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataPemesananApiData result;

  DataPemesananResultApi(this.status, this.result);

  factory DataPemesananResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataPemesananResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPemesananResultApiToJson(this);
}

