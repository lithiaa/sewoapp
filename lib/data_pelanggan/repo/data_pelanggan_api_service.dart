import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_api.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataPelangganApiService {
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

  Future<DataPelangganApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_pelanggan/tampil.php",
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
        return DataPelangganApi.fromJson(jsonDecode(response.data));
      }
      return DataPelangganApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPelangganResultApi> prosesSimpan(DataPelanggan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_pelanggan/proses_simpan.php",
        data: FormData.fromMap({
          'id_pelanggan': data.idPelanggan,
          'nama': data.nama,
          'alamat': data.alamat,
          'no_telepon': data.noTelepon,
          'email': data.email,
          'username': data.username,
          'password': data.password,
        }),
      );
      /* if (response.data is String) {
          return DataPelangganResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPelangganResultApi.fromJson(response.data); */
      return DataPelangganResultApi("success", DataPelangganApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPelangganResultApi> proseUbah(DataPelanggan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
          'id_pelanggan': data.idPelanggan,
          'nama': data.nama,
          'alamat': data.alamat,
          'no_telepon': data.noTelepon,
          'email': data.email,
          'username': data.username,
          'password': data.password,
        }),
      );
      /* if (response.data is String) {
        return DataPelangganResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPelangganResultApi.fromJson(response.data); */
      return DataPelangganResultApi(
        "berhasil",
        DataPelangganApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPelangganResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataPelangganResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataPelangganResultApi.fromJson(response.data); */
      return DataPelangganResultApi(
        "berhasil",
        DataPelangganApiData(),
      ); */
      return DataPelangganResultApi("success", DataPelangganApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPelangganResultApi> prosesUbah(DataPelanggan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_pelanggan/proses_update.php",
        data: FormData.fromMap({
          'id_pelanggan': data.idPelanggan,
          'nama': data.nama,
          'alamat': data.alamat,
          'no_telepon': data.noTelepon,
          'email': data.email,
          'username': data.username,
          'password': data.password,
        }),
      );
      /* if (response.data is String) {
        return DataPelangganResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataPelangganResultApi.fromJson(response.data); */
      return DataPelangganResultApi(
        "berhasil",
        DataPelangganApiData(),
      ); */
      return DataPelangganResultApi("success", DataPelangganApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
