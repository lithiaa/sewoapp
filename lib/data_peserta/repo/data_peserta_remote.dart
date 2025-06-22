import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_peserta/data/data_peserta.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_api.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_result_api.dart';
import 'package:sewoapp/data_peserta/repo/data_peserta_api_service.dart';

class DataPesertaRemote {
  final DataPesertaApiService _serviceApi = DataPesertaApiService();


  Future<DataPesertaApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataPesertaResultApi> prosesSimpan(DataPeserta data) {
    return _serviceApi.proseSimpan(data);
  }

  Future<DataPesertaResultApi> detail(DataFilter data) {
    return _serviceApi.detail(data);
  }
}

