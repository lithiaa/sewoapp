import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/login/data/login_apidata.dart';

part 'login_api.g.dart';

@JsonSerializable()
class LoginApi {
  final String status;
  final String? pesan;
  final LoginApiData? result;

  LoginApi(this.status, this.pesan, this.result);

  factory LoginApi.fromJson(Map<String, dynamic> json) =>
      _$LoginApiFromJson(json);

  Map<String, dynamic> toJson() => _$LoginApiToJson(this);
}
