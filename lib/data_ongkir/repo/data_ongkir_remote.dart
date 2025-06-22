import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_api.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_result_api.dart';
import 'package:sewoapp/data_ongkir/repo/data_ongkir_api_service.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir.dart';

class DataOngkirRemote {
  final DataOngkirApiService _serviceApi = DataOngkirApiService();


  Future<DataOngkirApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataOngkirResultApi> simpan(DataOngkir data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataOngkirResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataOngkirResultApi> ubah(DataOngkir data) {
    return _serviceApi.prosesUbah(data);
  }
}

