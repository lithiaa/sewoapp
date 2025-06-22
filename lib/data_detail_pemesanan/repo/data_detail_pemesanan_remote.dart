import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_api.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_result_api.dart';
import 'package:sewoapp/data_detail_pemesanan/repo/data_detail_pemesanan_api_service.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';

class DataDetailPemesananRemote {
  final DataDetailPemesananApiService _serviceApi = DataDetailPemesananApiService();


  Future<DataDetailPemesananApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataDetailPemesananResultApi> simpan(DataDetailPemesanan data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataDetailPemesananResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataDetailPemesananResultApi> ubah(DataDetailPemesanan data) {
    return _serviceApi.prosesUbah(data);
  }
}

