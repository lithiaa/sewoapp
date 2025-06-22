import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_api.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataOngkirApiService {
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

  Future<DataOngkirApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_ongkir/tampil.php",
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
        return DataOngkirApi.fromJson(jsonDecode(response.data));
      }
      return DataOngkirApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataOngkirResultApi> prosesSimpan(DataOngkir data) async {
    try {
      Response response = await dio.post(
        "app/page/data_ongkir/proses_simpan.php",
        data: FormData.fromMap({
        'id_kurir' : data.idKurir,
'kurir' : data.kurir,
'tujuan' : data.tujuan,
'biaya' : data.biaya,

        }),
      );
      /* if (response.data is String) {
          return DataOngkirResultApi.fromJson(jsonDecode(response.data));
      }
      return DataOngkirResultApi.fromJson(response.data); */
      return DataOngkirResultApi("success", DataOngkirApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataOngkirResultApi> proseUbah(DataOngkir data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_kurir' : data.idKurir,
'kurir' : data.kurir,
'tujuan' : data.tujuan,
'biaya' : data.biaya,

        }),
      );
      /* if (response.data is String) {
        return DataOngkirResultApi.fromJson(jsonDecode(response.data));
      }
      return DataOngkirResultApi.fromJson(response.data); */
      return DataOngkirResultApi(
        "berhasil",
        DataOngkirApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataOngkirResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataOngkirResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataOngkirResultApi.fromJson(response.data); */
      return DataOngkirResultApi(
        "berhasil",
        DataOngkirApiData(),
      ); */
      return DataOngkirResultApi("success", DataOngkirApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataOngkirResultApi> prosesUbah(DataOngkir data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_kurir' : data.idKurir,
'kurir' : data.kurir,
'tujuan' : data.tujuan,
'biaya' : data.biaya,

        }),
      );
      /* if (response.data is String) {
        return DataOngkirResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataOngkirResultApi.fromJson(response.data); */
      return DataOngkirResultApi(
        "berhasil",
        DataOngkirApiData(),
      ); */
      return DataOngkirResultApi("success", DataOngkirApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

