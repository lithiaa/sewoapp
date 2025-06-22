import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_api.dart';
import 'package:sewoapp/data_katalog/repo/data_katalog_api_service.dart';

class DataKatalogRemote {
  final DataKatalogApiService _serviceApi = DataKatalogApiService();

  Future<DataKatalogApi> getData(FilterKatalog filter) {
    if (filter.type.toLowerCase().contains("terbaru")) {
      return _serviceApi.getDataTerbaru(filter);
    }
    if (filter.type.toLowerCase().contains("terlaris")) {
      return _serviceApi.getDataTerlaris(filter);
    }
    if (filter.type.toLowerCase().contains("semua")) {
      return _serviceApi.getData(filter);
    }
    return Future.error("Invalid type value");
  }
}
