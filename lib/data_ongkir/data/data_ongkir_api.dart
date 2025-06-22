import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';

part 'data_ongkir_api.g.dart';

@JsonSerializable()
class DataOngkirApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataOngkirApiData> result;

  DataOngkirApi(this.status, this.result);


  factory DataOngkirApi.fromJson(Map<String, dynamic> json) =>
      _$DataOngkirApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataOngkirApiToJson(this);
}
