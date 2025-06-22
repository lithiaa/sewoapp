import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data/data_hapus.dart';

part 'data_ongkir_apidata.g.dart';

@JsonSerializable()
class DataOngkirApiData implements DataHapus {
  DataOngkirApiData({
    this.idKurir,
    this.kurir,
    this.tujuan,
    this.biaya,
  });

  @JsonKey(name: "id_ongkir")
  final String? idKurir;
  @JsonKey(name: "kurir")
  final String? kurir;
  @JsonKey(name: "tujuan")
  final String? tujuan;
  @JsonKey(name: "biaya")
  final String? biaya;

  factory DataOngkirApiData.fromJson(Map<String, dynamic> json) =>
      _$DataOngkirApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataOngkirApiDataToJson(this);

  @override
  String getIdHapus() {
    return "$idKurir";
  }
}
