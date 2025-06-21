import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_apidata.dart';

part 'data_satuan_result_api.g.dart';

@JsonSerializable()
class DataSatuanResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataSatuanApiData result;

  DataSatuanResultApi(this.status, this.result);

  factory DataSatuanResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataSatuanResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataSatuanResultApiToJson(this);
}

