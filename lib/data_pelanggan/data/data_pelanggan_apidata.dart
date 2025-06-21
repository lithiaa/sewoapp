import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_pelanggan_apidata.g.dart';

@JsonSerializable()
class DataPelangganApiData implements DataHapus {
    DataPelangganApiData({
                              	this.idPelanggan,
	this.nama,
	this.alamat,
	this.noTelepon,
	this.email,
	this.username,
	this.password,

                          });

    	@JsonKey(name: "id_pelanggan")
    final String? idPelanggan;
	@JsonKey(name: "nama")
    final String? nama;
	@JsonKey(name: "alamat")
    final String? alamat;
	@JsonKey(name: "no_telepon")
    final String? noTelepon;
	@JsonKey(name: "email")
    final String? email;
	@JsonKey(name: "username")
    final String? username;
	@JsonKey(name: "password")
    final String? password;


  factory DataPelangganApiData.fromJson(Map<String, dynamic> json) =>
      _$DataPelangganApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataPelangganApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idPelanggan";
  }
}

