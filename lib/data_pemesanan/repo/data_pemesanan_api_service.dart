import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_api.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_apidata.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataPemesananApiService {
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

  Future<DataPemesananApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_pemesanan/tampil.php",
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
        return DataPemesananApi.fromJson(jsonDecode(response.data));
      }
      return DataPemesananApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPemesananResultApi> prosesSimpan(DataPemesanan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_pemesanan/proses_simpan.php",
        data: FormData.fromMap({
        'id_pemesanan' : data.idPemesanan,
'tanggal_pemesanan' : data.tanggalPemesanan,
'id_pelanggan' : data.idPelanggan,
'id_ongkir' : data.idOngkir,
'id_bank' : data.idBank,
'tanggal_upload_bukti_pembayaran' : data.tanggalUploadBuktiPembayaran,
'upload_bukti_pembayaran' : data.uploadBuktiPembayaran,
'status' : data.status,

        }),
      );
      /* if (response.data is String) {
          return DataPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPemesananResultApi.fromJson(response.data); */
      return DataPemesananResultApi("success", DataPemesananApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPemesananResultApi> proseUbah(DataPemesanan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_pemesanan' : data.idPemesanan,
'tanggal_pemesanan' : data.tanggalPemesanan,
'id_pelanggan' : data.idPelanggan,
'id_ongkir' : data.idOngkir,
'id_bank' : data.idBank,
'tanggal_upload_bukti_pembayaran' : data.tanggalUploadBuktiPembayaran,
'upload_bukti_pembayaran' : data.uploadBuktiPembayaran,
'status' : data.status,

        }),
      );
      /* if (response.data is String) {
        return DataPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPemesananResultApi.fromJson(response.data); */
      return DataPemesananResultApi(
        "berhasil",
        DataPemesananApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPemesananResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataPemesananResultApi.fromJson(response.data); */
      return DataPemesananResultApi(
        "berhasil",
        DataPemesananApiData(),
      ); */
      return DataPemesananResultApi("success", DataPemesananApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPemesananResultApi> prosesUbah(DataPemesanan data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_pemesanan' : data.idPemesanan,
'tanggal_pemesanan' : data.tanggalPemesanan,
'id_pelanggan' : data.idPelanggan,
'id_ongkir' : data.idOngkir,
'id_bank' : data.idBank,
'tanggal_upload_bukti_pembayaran' : data.tanggalUploadBuktiPembayaran,
'upload_bukti_pembayaran' : data.uploadBuktiPembayaran,
'status' : data.status,

        }),
      );
      /* if (response.data is String) {
        return DataPemesananResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataPemesananResultApi.fromJson(response.data); */
      return DataPemesananResultApi(
        "berhasil",
        DataPemesananApiData(),
      ); */
      return DataPemesananResultApi("success", DataPemesananApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

