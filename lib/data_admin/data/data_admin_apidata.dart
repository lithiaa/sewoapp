import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_admin_apidata.g.dart';

@JsonSerializable()
class DataAdminApiData implements DataHapus {
    DataAdminApiData({
                              	this.idAdmin,
	this.nama,
	this.username,
	this.password,

                          });

    	@JsonKey(name: "id_admin")
    final String? idAdmin;
	@JsonKey(name: "nama")
    final String? nama;
	@JsonKey(name: "username")
    final String? username;
	@JsonKey(name: "password")
    final String? password;


  factory DataAdminApiData.fromJson(Map<String, dynamic> json) =>
      _$DataAdminApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataAdminApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idAdmin";
  }
}

