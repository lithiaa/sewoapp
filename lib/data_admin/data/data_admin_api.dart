import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_admin/data/data_admin_apidata.dart';

part 'data_admin_api.g.dart';

@JsonSerializable()
class DataAdminApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataAdminApiData> result;

  DataAdminApi(this.status, this.result);


  factory DataAdminApi.fromJson(Map<String, dynamic> json) =>
      _$DataAdminApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataAdminApiToJson(this);
}
