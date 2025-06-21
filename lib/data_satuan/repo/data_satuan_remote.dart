import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_api.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_result_api.dart';
import 'package:sewoapp/data_satuan/repo/data_satuan_api_service.dart';
import 'package:sewoapp/data_satuan/data/data_satuan.dart';

class DataSatuanRemote {
  final DataSatuanApiService _serviceApi = DataSatuanApiService();


  Future<DataSatuanApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataSatuanResultApi> simpan(DataSatuan data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataSatuanResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataSatuanResultApi> ubah(DataSatuan data) {
    return _serviceApi.prosesUbah(data);
  }
}

