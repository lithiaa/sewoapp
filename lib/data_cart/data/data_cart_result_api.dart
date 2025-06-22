import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_cart/data/data_cart_apidata.dart';

part 'data_cart_result_api.g.dart';

@JsonSerializable()
class DataCartResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataCartApiData result;

  DataCartResultApi(this.status, this.result);

  factory DataCartResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataCartResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataCartResultApiToJson(this);
}

