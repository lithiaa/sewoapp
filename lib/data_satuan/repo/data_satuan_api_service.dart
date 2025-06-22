import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_satuan/data/data_satuan.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_api.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_apidata.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataSatuanApiService {
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

  Future<DataSatuanApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_satuan/tampil.php",
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
        return DataSatuanApi.fromJson(jsonDecode(response.data));
      }
      return DataSatuanApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataSatuanResultApi> prosesSimpan(DataSatuan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_satuan/proses_simpan.php",
        data: FormData.fromMap({
        'id_satuan' : data.idSatuan,
'satuan' : data.satuan,

        }),
      );
      /* if (response.data is String) {
          return DataSatuanResultApi.fromJson(jsonDecode(response.data));
      }
      return DataSatuanResultApi.fromJson(response.data); */
      return DataSatuanResultApi("success", DataSatuanApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataSatuanResultApi> proseUbah(DataSatuan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_satuan' : data.idSatuan,
'satuan' : data.satuan,

        }),
      );
      /* if (response.data is String) {
        return DataSatuanResultApi.fromJson(jsonDecode(response.data));
      }
      return DataSatuanResultApi.fromJson(response.data); */
      return DataSatuanResultApi(
        "berhasil",
        DataSatuanApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataSatuanResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataSatuanResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataSatuanResultApi.fromJson(response.data); */
      return DataSatuanResultApi(
        "berhasil",
        DataSatuanApiData(),
      ); */
      return DataSatuanResultApi("success", DataSatuanApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataSatuanResultApi> prosesUbah(DataSatuan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_satuan' : data.idSatuan,
'satuan' : data.satuan,

        }),
      );
      /* if (response.data is String) {
        return DataSatuanResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataSatuanResultApi.fromJson(response.data); */
      return DataSatuanResultApi(
        "berhasil",
        DataSatuanApiData(),
      ); */
      return DataSatuanResultApi("success", DataSatuanApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

