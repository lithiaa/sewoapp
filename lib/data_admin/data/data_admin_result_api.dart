import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_admin/data/data_admin_apidata.dart';

part 'data_admin_result_api.g.dart';

@JsonSerializable()
class DataAdminResultApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final DataAdminApiData result;

  DataAdminResultApi(this.status, this.result);

  factory DataAdminResultApi.fromJson(Map<String, dynamic> json) =>
      _$DataAdminResultApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataAdminResultApiToJson(this);
}

