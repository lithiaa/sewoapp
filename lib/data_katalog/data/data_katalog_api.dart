import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';

part 'data_katalog_api.g.dart';

@JsonSerializable()
class DataKatalogApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataKatalogApiData> result;

  DataKatalogApi(this.status, this.result);

  factory DataKatalogApi.fromJson(Map<String, dynamic> json) =>
      _$DataKatalogApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataKatalogApiToJson(this);
}
