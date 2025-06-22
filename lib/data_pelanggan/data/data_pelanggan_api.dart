import 'package:json_annotation/json_annotation.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';

part 'data_pelanggan_api.g.dart';

@JsonSerializable()
class DataPelangganApi {

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'result')
  final List<DataPelangganApiData> result;

  DataPelangganApi(this.status, this.result);


  factory DataPelangganApi.fromJson(Map<String, dynamic> json) =>
      _$DataPelangganApiFromJson(json);

  Map<String, dynamic> toJson() => _$DataPelangganApiToJson(this);
}
