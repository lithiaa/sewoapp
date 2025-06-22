import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_admin/data/data_admin_api.dart';
import 'package:sewoapp/data_admin/data/data_admin_result_api.dart';
import 'package:sewoapp/data_admin/repo/data_admin_api_service.dart';
import 'package:sewoapp/data_admin/data/data_admin.dart';

class DataAdminRemote {
  final DataAdminApiService _serviceApi = DataAdminApiService();


  Future<DataAdminApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataAdminResultApi> simpan(DataAdmin data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataAdminResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataAdminResultApi> ubah(DataAdmin data) {
    return _serviceApi.prosesUbah(data);
  }
}

