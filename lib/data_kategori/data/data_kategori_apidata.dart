import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_kategori_apidata.g.dart';

@JsonSerializable()
class DataKategoriApiData implements DataHapus {
    DataKategoriApiData({
                              	this.idKategori,
	this.kategori,

                          });

    	@JsonKey(name: "id_kategori")
    final String? idKategori;
	@JsonKey(name: "kategori")
    final String? kategori;


  factory DataKategoriApiData.fromJson(Map<String, dynamic> json) =>
      _$DataKategoriApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataKategoriApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idKategori";
  }
}

