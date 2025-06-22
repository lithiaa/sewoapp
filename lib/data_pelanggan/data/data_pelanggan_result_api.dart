import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';

part 'data_pelanggan_result_api.g.dart';

@JsonSerializable()
class DataPelangganResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataPelangganApiData result;

  DataPelangganResultApi(this.status, this.result);

  factory DataPelangganResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataPelangganResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPelangganResultApiToJson(this);
}

