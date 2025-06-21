import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_produk/data/data_produk.dart';
import 'package:sewoapp/data_produk/data/data_produk_api.dart';
import 'package:sewoapp/data_produk/data/data_produk_apidata.dart';
import 'package:sewoapp/data_produk/data/data_produk_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataProdukApiService {
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

  Future<DataProdukApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_produk/tampil.php",
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
        return DataProdukApi.fromJson(jsonDecode(response.data));
      }
      return DataProdukApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataProdukResultApi> prosesSimpan(DataProduk data) async {
    try {
      Response response = await dio.post(
        "app/page/data_produk/proses_simpan.php",
        data: FormData.fromMap({
        'id_produk' : data.idProduk,
'nama_produk' : data.namaProduk,
'id_kategori' : data.idKategori,
'harga' : data.harga,
'jumlah' : data.jumlah,
'deskripsi' : data.deskripsi,

        }),
      );
      /* if (response.data is String) {
          return DataProdukResultApi.fromJson(jsonDecode(response.data));
      }
      return DataProdukResultApi.fromJson(response.data); */
      return DataProdukResultApi("success", DataProdukApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataProdukResultApi> proseUbah(DataProduk data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_produk' : data.idProduk,
'nama_produk' : data.namaProduk,
'id_kategori' : data.idKategori,
'harga' : data.harga,
'jumlah' : data.jumlah,
'deskripsi' : data.deskripsi,

        }),
      );
      /* if (response.data is String) {
        return DataProdukResultApi.fromJson(jsonDecode(response.data));
      }
      return DataProdukResultApi.fromJson(response.data); */
      return DataProdukResultApi(
        "berhasil",
        DataProdukApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataProdukResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataProdukResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataProdukResultApi.fromJson(response.data); */
      return DataProdukResultApi(
        "berhasil",
        DataProdukApiData(),
      ); */
      return DataProdukResultApi("success", DataProdukApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataProdukResultApi> prosesUbah(DataProduk data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_produk' : data.idProduk,
'nama_produk' : data.namaProduk,
'id_kategori' : data.idKategori,
'harga' : data.harga,
'jumlah' : data.jumlah,
'deskripsi' : data.deskripsi,

        }),
      );
      /* if (response.data is String) {
        return DataProdukResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataProdukResultApi.fromJson(response.data); */
      return DataProdukResultApi(
        "berhasil",
        DataProdukApiData(),
      ); */
      return DataProdukResultApi("success", DataProdukApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

