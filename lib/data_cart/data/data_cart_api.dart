import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_cart/data/data_cart_apidata.dart';

part 'data_cart_api.g.dart';

@JsonSerializable()
class DataCartApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataCartApiData> result;

  DataCartApi(this.status, this.result);

  bool cartEmpty() {
    if (result.isEmpty) return true;
    if (result.first.details == null) return true;
    if (result.first.details!.isEmpty) return true;
    return false;
  }

  factory DataCartApi.fromJson(Map<String, dynamic> json) =>
      _$DataCartApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataCartApiToJson(this);
}
