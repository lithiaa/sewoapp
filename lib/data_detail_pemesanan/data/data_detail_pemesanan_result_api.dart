import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';

part 'data_detail_pemesanan_result_api.g.dart';

@JsonSerializable()
class DataDetailPemesananResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataDetailPemesananApiData result;

  DataDetailPemesananResultApi(this.status, this.result);

  factory DataDetailPemesananResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataDetailPemesananResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailPemesananResultApiToJson(this);
}

