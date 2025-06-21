import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';

part 'data_detail_pemesanan_api.g.dart';

@JsonSerializable()
class DataDetailPemesananApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataDetailPemesananApiData> result;

  DataDetailPemesananApi(this.status, this.result);


  factory DataDetailPemesananApi.fromJson(Map<String, dynamic> json) =>
      _$DataDetailPemesananApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailPemesananApiToJson(this);
}
