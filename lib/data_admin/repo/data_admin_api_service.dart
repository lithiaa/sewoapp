import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_admin/data/data_admin.dart';
import 'package:sewoapp/data_admin/data/data_admin_api.dart';
import 'package:sewoapp/data_admin/data/data_admin_apidata.dart';
import 'package:sewoapp/data_admin/data/data_admin_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataAdminApiService {
  Dio get dio => _dio();
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: '${ConfigGlobal.baseUrl}/api/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
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

  Future<DataAdminApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_admin/tampil.php",
        data: FormData.fromMap({
          'berdasarkan': filter.berdasarkan,
          'isi': filter.isi,
          'limit': filter.limit,
          'hal': filter.hal,
          'dari': filter.dari,
          'sampai': filter.sampai
        }),
      );
      if (response.data is String) {
        return DataAdminApi.fromJson(jsonDecode(response.data));
      }
      return DataAdminApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataAdminResultApi> prosesSimpan(DataAdmin data) async {
    try {
      Response response = await dio.post(
        "app/page/data_admin/proses_simpan.php",
        data: FormData.fromMap({
        'id_admin' : data.idAdmin,
'nama' : data.nama,
'username' : data.username,
'password' : data.password,

        }),
      );
      /* if (response.data is String) {
          return DataAdminResultApi.fromJson(jsonDecode(response.data));
      }
      return DataAdminResultApi.fromJson(response.data); */
      return DataAdminResultApi("success", DataAdminApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataAdminResultApi> proseUbah(DataAdmin data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_admin' : data.idAdmin,
'nama' : data.nama,
'username' : data.username,
'password' : data.password,

        }),
      );
      /* if (response.data is String) {
        return DataAdminResultApi.fromJson(jsonDecode(response.data));
      }
      return DataAdminResultApi.fromJson(response.data); */
      return DataAdminResultApi(
        "berhasil",
        DataAdminApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataAdminResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataAdminResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataAdminResultApi.fromJson(response.data); */
      return DataAdminResultApi(
        "berhasil",
        DataAdminApiData(),
      ); */
      return DataAdminResultApi("success", DataAdminApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataAdminResultApi> prosesUbah(DataAdmin data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_admin' : data.idAdmin,
'nama' : data.nama,
'username' : data.username,
'password' : data.password,

        }),
      );
      /* if (response.data is String) {
        return DataAdminResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataAdminResultApi.fromJson(response.data); */
      return DataAdminResultApi(
        "berhasil",
        DataAdminApiData(),
      ); */
      return DataAdminResultApi("success", DataAdminApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

