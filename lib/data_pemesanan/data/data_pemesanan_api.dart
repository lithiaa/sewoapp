import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_apidata.dart';

part 'data_pemesanan_api.g.dart';

@JsonSerializable()
class DataPemesananApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataPemesananApiData> result;

  DataPemesananApi(this.status, this.result);


  factory DataPemesananApi.fromJson(Map<String, dynamic> json) =>
      _$DataPemesananApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPemesananApiToJson(this);
}
