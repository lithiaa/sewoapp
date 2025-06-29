import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_cart/data/data_cart_api.dart';
import 'package:sewoapp/data_cart/data/data_cart_result_api.dart';
import 'package:sewoapp/data_cart/repo/data_cart_api_service.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';

class DataCartRemote {
  final DataCartApiService _serviceApi = DataCartApiService();

  Future<DataCartApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataCartResultApi> prosesSelesai(DataCart data) {
    return _serviceApi.prosesSelesai(data);
  }

  Future<DataCartResultApi> simpan(DataCart data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataCartResultApi> prosesAddCart(DataCart data) {
    return _serviceApi.prosesAddCart(data);
  }

  Future<DataCartResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataCartResultApi> ubah(DataCart data) {
    return _serviceApi.prosesUbah(data);
  }

  Future<DataCartResultApi> updateQuantity(String idProduk, String jumlah, String idPelanggan) {
    return _serviceApi.updateQuantity(idProduk, jumlah, idPelanggan);
  }
}
