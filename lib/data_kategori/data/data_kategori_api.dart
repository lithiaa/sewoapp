import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_apidata.dart';

part 'data_kategori_api.g.dart';

@JsonSerializable()
class DataKategoriApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataKategoriApiData> result;

  DataKategoriApi(this.status, this.result);


  factory DataKategoriApi.fromJson(Map<String, dynamic> json) =>
      _$DataKategoriApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataKategoriApiToJson(this);
}
