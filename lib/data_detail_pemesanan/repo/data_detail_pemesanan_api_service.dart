import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_api.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataDetailPemesananApiService {
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

  Future<DataDetailPemesananApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_detail_pemesanan/tampil.php",
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
        return DataDetailPemesananApi.fromJson(jsonDecode(response.data));
      }
      return DataDetailPemesananApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataDetailPemesananResultApi> prosesSimpan(
      DataDetailPemesanan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_detail_pemesanan/proses_simpan.php",
        data: FormData.fromMap({
          'id_detail_pemesanan': data.idDetailPemesanan,
          'id_pemesanan': data.idPemesanan,
          'id_produk': data.idProduk,
          'jumlah': data.jumlah,
          'harga': data.harga,
        }),
      );
      /* if (response.data is String) {
          return DataDetailPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      return DataDetailPemesananResultApi.fromJson(response.data); */
      return DataDetailPemesananResultApi(
          "success", DataDetailPemesananApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataDetailPemesananResultApi> proseUbah(
      DataDetailPemesanan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
          'id_detail_pemesanan': data.idDetailPemesanan,
          'id_pemesanan': data.idPemesanan,
          'id_produk': data.idProduk,
          'jumlah': data.jumlah,
          'harga': data.harga,
        }),
      );
      /* if (response.data is String) {
        return DataDetailPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      return DataDetailPemesananResultApi.fromJson(response.data); */
      return DataDetailPemesananResultApi(
        "berhasil",
        DataDetailPemesananApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataDetailPemesananResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataDetailPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataDetailPemesananResultApi.fromJson(response.data); */
      return DataDetailPemesananResultApi(
        "berhasil",
        DataDetailPemesananApiData(),
      ); */
      return DataDetailPemesananResultApi(
          "success", DataDetailPemesananApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataDetailPemesananResultApi> prosesUbah(
      DataDetailPemesanan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
          'id_detail_pemesanan': data.idDetailPemesanan,
          'id_pemesanan': data.idPemesanan,
          'id_produk': data.idProduk,
          'jumlah': data.jumlah,
          'harga': data.harga,
        }),
      );
      /* if (response.data is String) {
        return DataDetailPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataDetailPemesananResultApi.fromJson(response.data); */
      return DataDetailPemesananResultApi(
        "berhasil",
        DataDetailPemesananApiData(),
      ); */
      return DataDetailPemesananResultApi(
          "success", DataDetailPemesananApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
