import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_bank/data/data_bank.dart';
import 'package:sewoapp/data_bank/data/data_bank_api.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';
import 'package:sewoapp/data_bank/data/data_bank_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataBankApiService {
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

  Future<DataBankApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_bank/tampil.php",
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
        return DataBankApi.fromJson(jsonDecode(response.data));
      }
      return DataBankApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataBankResultApi> prosesSimpan(DataBank data) async {
    try {
      Response response = await dio.post(
        "app/page/data_bank/proses_simpan.php",
        data: FormData.fromMap({
        'id_bank' : data.idBank,
'nama_bank' : data.namaBank,
'nama_pemilik' : data.namaPemilik,
'rekening' : data.rekening,
'foto_logo_bank' : data.fotoLogoBank,

        }),
      );
      /* if (response.data is String) {
          return DataBankResultApi.fromJson(jsonDecode(response.data));
      }
      return DataBankResultApi.fromJson(response.data); */
      return DataBankResultApi("success", DataBankApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataBankResultApi> proseUbah(DataBank data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_bank' : data.idBank,
'nama_bank' : data.namaBank,
'nama_pemilik' : data.namaPemilik,
'rekening' : data.rekening,
'foto_logo_bank' : data.fotoLogoBank,

        }),
      );
      /* if (response.data is String) {
        return DataBankResultApi.fromJson(jsonDecode(response.data));
      }
      return DataBankResultApi.fromJson(response.data); */
      return DataBankResultApi(
        "berhasil",
        DataBankApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataBankResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataBankResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataBankResultApi.fromJson(response.data); */
      return DataBankResultApi(
        "berhasil",
        DataBankApiData(),
      ); */
      return DataBankResultApi("success", DataBankApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataBankResultApi> prosesUbah(DataBank data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
        'id_bank' : data.idBank,
'nama_bank' : data.namaBank,
'nama_pemilik' : data.namaPemilik,
'rekening' : data.rekening,
'foto_logo_bank' : data.fotoLogoBank,

        }),
      );
      /* if (response.data is String) {
        return DataBankResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataBankResultApi.fromJson(response.data); */
      return DataBankResultApi(
        "berhasil",
        DataBankApiData(),
      ); */
      return DataBankResultApi("success", DataBankApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

