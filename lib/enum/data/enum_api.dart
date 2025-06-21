import 'package:json_annotation/json_annotation.dart';

part 'enum_api.g.dart';

@JsonSerializable()
class EnumApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<String> result;

  EnumApi(this.status, this.result);

  factory EnumApi.fromJson(Map<String, dynamic> json) =>
      _$EnumApiFromJson(json);

  Map<String, dynamic> toJson() => _$EnumApiToJson(this);
}
