import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_satuan_apidata.g.dart';

@JsonSerializable()
class DataSatuanApiData implements DataHapus {
    DataSatuanApiData({
                              	this.idSatuan,
	this.satuan,

                          });

    	@JsonKey(name: "id_satuan")
    final String? idSatuan;
	@JsonKey(name: "satuan")
    final String? satuan;


  factory DataSatuanApiData.fromJson(Map<String, dynamic> json) =>
      _$DataSatuanApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataSatuanApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idSatuan";
  }
}

