import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_apidata.dart';

part 'data_kategori_result_api.g.dart';

@JsonSerializable()
class DataKategoriResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataKategoriApiData result;

  DataKategoriResultApi(this.status, this.result);

  factory DataKategoriResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataKategoriResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataKategoriResultApiToJson(this);
}

