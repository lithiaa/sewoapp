import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_produk/data/data_produk_apidata.dart';

part 'data_produk_result_api.g.dart';

@JsonSerializable()
class DataProdukResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataProdukApiData result;

  DataProdukResultApi(this.status, this.result);

  factory DataProdukResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataProdukResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataProdukResultApiToJson(this);
}

