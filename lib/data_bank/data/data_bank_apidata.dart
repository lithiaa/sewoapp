import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_bank_apidata.g.dart';

@JsonSerializable()
class DataBankApiData implements DataHapus {
    DataBankApiData({
                              	this.idBank,
	this.namaBank,
	this.namaPemilik,
	this.rekening,
	this.fotoLogoBank,

                          });

    	@JsonKey(name: "id_bank")
    final String? idBank;
	@JsonKey(name: "nama_bank")
    final String? namaBank;
	@JsonKey(name: "nama_pemilik")
    final String? namaPemilik;
	@JsonKey(name: "rekening")
    final String? rekening;
	@JsonKey(name: "foto_logo_bank")
    final String? fotoLogoBank;


  factory DataBankApiData.fromJson(Map<String, dynamic> json) =>
      _$DataBankApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataBankApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idBank";
  }
}

