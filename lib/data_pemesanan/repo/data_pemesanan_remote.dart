import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_api.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_result_api.dart';
import 'package:sewoapp/data_pemesanan/repo/data_pemesanan_api_service.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan.dart';

class DataPemesananRemote {
  final DataPemesananApiService _serviceApi = DataPemesananApiService();


  Future<DataPemesananApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataPemesananResultApi> simpan(DataPemesanan data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataPemesananResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataPemesananResultApi> ubah(DataPemesanan data) {
    return _serviceApi.prosesUbah(data);
  }
}

