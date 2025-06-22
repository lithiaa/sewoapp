import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_produk/data/data_produk_api.dart';
import 'package:sewoapp/data_produk/data/data_produk_result_api.dart';
import 'package:sewoapp/data_produk/repo/data_produk_api_service.dart';
import 'package:sewoapp/data_produk/data/data_produk.dart';

class DataProdukRemote {
  final DataProdukApiService _serviceApi = DataProdukApiService();


  Future<DataProdukApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataProdukResultApi> simpan(DataProduk data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataProdukResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataProdukResultApi> ubah(DataProduk data) {
    return _serviceApi.prosesUbah(data);
  }
}

