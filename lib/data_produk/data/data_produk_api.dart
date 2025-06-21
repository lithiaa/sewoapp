import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_produk/data/data_produk_apidata.dart';

part 'data_produk_api.g.dart';

@JsonSerializable()
class DataProdukApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataProdukApiData> result;

  DataProdukApi(this.status, this.result);


  factory DataProdukApi.fromJson(Map<String, dynamic> json) =>
      _$DataProdukApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataProdukApiToJson(this);
}
