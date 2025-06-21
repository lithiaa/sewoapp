import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_apidata.dart';

part 'data_satuan_api.g.dart';

@JsonSerializable()
class DataSatuanApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataSatuanApiData> result;

  DataSatuanApi(this.status, this.result);


  factory DataSatuanApi.fromJson(Map<String, dynamic> json) =>
      _$DataSatuanApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataSatuanApiToJson(this);
}
