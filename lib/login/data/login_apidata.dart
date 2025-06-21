import 'package:json_annotation/json_annotation.dart';

part 'login_apidata.g.dart';

@JsonSerializable()
class LoginApiData {
  LoginApiData({this.id, this.jabatan, this.namaPegawai, this.tkn});

  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "jabatan")
  final String? jabatan;

  @JsonKey(name: "nama_pegawai")
  final String? namaPegawai;

  @JsonKey(name: "tkn")
  final String? tkn;

  factory LoginApiData.fromJson(Map<String, dynamic> json) =>
      _$LoginApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginApiDataToJson(this);
}
