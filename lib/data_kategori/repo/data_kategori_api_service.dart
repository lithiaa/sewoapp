import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_kategori/data/data_kategori.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_api.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_apidata.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataKategoriApiService {
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

  Future<DataKategoriApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_kategori/tampil.php",
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
        return DataKategoriApi.fromJson(jsonDecode(response.data));
      }
      return DataKategoriApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataKategoriResultApi> prosesSimpan(DataKategori data) async {
    try {
      Response response = await dio.post(
        "app/page/data_kategori/proses_simpan.php",
        data: FormData.fromMap({
        'id_kategori' : data.idKategori,
'kategori' : data.kategori,

        }),
      );
      /* if (response.data is String) {
          return DataKategoriResultApi.fromJson(jsonDecode(response.data));
      }
      return DataKategoriResultApi.fromJson(response.data); */
      return DataKategoriResultApi("success", DataKategoriApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataKategoriResultApi> proseUbah(DataKategori data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_kategori' : data.idKategori,
'kategori' : data.kategori,

        }),
      );
      /* if (response.data is String) {
        return DataKategoriResultApi.fromJson(jsonDecode(response.data));
      }
      return DataKategoriResultApi.fromJson(response.data); */
      return DataKategoriResultApi(
        "berhasil",
        DataKategoriApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataKategoriResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataKategoriResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataKategoriResultApi.fromJson(response.data); */
      return DataKategoriResultApi(
        "berhasil",
        DataKategoriApiData(),
      ); */
      return DataKategoriResultApi("success", DataKategoriApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataKategoriResultApi> prosesUbah(DataKategori data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_kategori' : data.idKategori,
'kategori' : data.kategori,

        }),
      );
      /* if (response.data is String) {
        return DataKategoriResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataKategoriResultApi.fromJson(response.data); */
      return DataKategoriResultApi(
        "berhasil",
        DataKategoriApiData(),
      ); */
      return DataKategoriResultApi("success", DataKategoriApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

