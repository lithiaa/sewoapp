import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_api.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_result_api.dart';
import 'package:sewoapp/data_kategori/repo/data_kategori_api_service.dart';
import 'package:sewoapp/data_kategori/data/data_kategori.dart';

class DataKategoriRemote {
  final DataKategoriApiService _serviceApi = DataKategoriApiService();


  Future<DataKategoriApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataKategoriResultApi> simpan(DataKategori data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataKategoriResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataKategoriResultApi> ubah(DataKategori data) {
    return _serviceApi.prosesUbah(data);
  }
}

