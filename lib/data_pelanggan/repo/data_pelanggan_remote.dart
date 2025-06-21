import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_api.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_result_api.dart';
import 'package:sewoapp/data_pelanggan/repo/data_pelanggan_api_service.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';

class DataPelangganRemote {
  final DataPelangganApiService _serviceApi = DataPelangganApiService();


  Future<DataPelangganApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataPelangganResultApi> simpan(DataPelanggan data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataPelangganResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataPelangganResultApi> ubah(DataPelanggan data) {
    return _serviceApi.prosesUbah(data);
  }
}

