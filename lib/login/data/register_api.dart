import 'package:json_annotation/json_annotation.dart';

part 'register_api.g.dart';

@JsonSerializable()
class RegisterApi {
  final String status;
  final String? pesan;

  RegisterApi(this.status, this.pesan);

  factory RegisterApi.fromJson(Map<String, dynamic> json) =>
      _$RegisterApiFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterApiToJson(this);
}
