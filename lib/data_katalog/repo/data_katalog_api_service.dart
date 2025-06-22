import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataKatalogApiService {
  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: '${ConfigGlobal.baseUrl}/api/',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      contentType: "application/json;charset=utf-8",
    );

    var dio = Dio(options);

    dio.interceptors.add(AwesomeDioInterceptor(
      logRequestTimeout: false,
      logRequestHeaders: false,
      logResponseHeaders: false,

      // Optional, defaults to the 'log' function in the 'dart:developer' package.
      logger: debugPrint,
    ));

    return dio;
  }

  Future<DataKatalogApi> getData(FilterKatalog filter) async {
    try {
      Response response = await dio.post("app/page/data_produk/tampil.php",
          data: FormData.fromMap({
            'berdasarkan': filter.berdasarkan,
            'isi': filter.isi,
            'limit': filter.limit,
            'hal': filter.hal,
            'dari': filter.dari,
            'type': filter.type,
            'sampai': filter.sampai
          }));
      if (response.data is String) {
        return DataKatalogApi.fromJson(jsonDecode(response.data));
      }
      return DataKatalogApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataKatalogApi> getDataTerlaris(FilterKatalog filter) async {
    try {
      Response response = await dio.post("app/page/data_produk/terlaris.php",
          data: FormData.fromMap({
            'berdasarkan': filter.berdasarkan,
            'isi': filter.isi,
            'limit': filter.limit,
            'hal': filter.hal,
            'dari': filter.dari,
            'type': filter.type,
            'sampai': filter.sampai
          }));
      if (response.data is String) {
        return DataKatalogApi.fromJson(jsonDecode(response.data));
      }
      return DataKatalogApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataKatalogApi> getDataTerbaru(FilterKatalog filter) async {
    try {
      Response response = await dio.post("app/page/data_produk/terbaru.php",
          data: FormData.fromMap({
            'berdasarkan': filter.berdasarkan,
            'isi': filter.isi,
            'limit': filter.limit,
            'hal': filter.hal,
            'dari': filter.dari,
            'type': filter.type,
            'sampai': filter.sampai
          }));
      if (response.data is String) {
        return DataKatalogApi.fromJson(jsonDecode(response.data));
      }
      return DataKatalogApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
