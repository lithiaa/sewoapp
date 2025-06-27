import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
import 'package:sewoapp/data_cart/data/data_cart_api.dart';
import 'package:sewoapp/data_cart/data/data_cart_apidata.dart';
import 'package:sewoapp/data_cart/data/data_cart_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataCartApiService {
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

  Future<DataCartApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_cart/tampil.php",
        data: FormData.fromMap({
          'berdasarkan': filter.berdasarkan,
          'isi': filter.isi,
          'limit': filter.limit,
          'hal': filter.hal,
          'dari': filter.dari,
          'sampai': filter.sampai,
          'id': filter.idPeserta,
        }),
      );
      if (response.data is String) {
        return DataCartApi.fromJson(jsonDecode(response.data));
      }
      return DataCartApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesSimpan(DataCart data) async {
    try {
      Response response = await dio.post(
        "app/page/data_cart/proses_add_cart.php",
        data: FormData.fromMap({
          'id_pemesanan': data.idPemesanan,
          'tanggal_pemesanan': data.tanggalPemesanan,
          'id_pelanggan': data.idPelanggan,
          'id_ongkir': data.idOngkir,
          'id_bank': data.idBank,
          'tanggal_upload_bukti_pembayaran': data.tanggalUploadBuktiPembayaran,
          'upload_bukti_pembayaran': data.uploadBuktiPembayaran,
          'status': data.status,
        }),
      );
      /* if (response.data is String) {
          return DataCartResultApi.fromJson(jsonDecode(response.data));
      }
      return DataCartResultApi.fromJson(response.data); */
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesAddCart(DataCart data) async {
    if (data.detail == null) {
      throw Exception("DataCart.detail bernilai null");
    }
    try {
      Response response = await dio.post(
        "app/page/data_cart/proses_add_cart.php",
        data: FormData.fromMap({
          'id_pemesanan': data.idPemesanan,
          'tanggal_pemesanan': data.tanggalPemesanan,
          'id_pelanggan': data.idPelanggan,
          'id_ongkir': data.idOngkir,
          'id_bank': data.idBank,
          'tanggal_upload_bukti_pembayaran': data.tanggalUploadBuktiPembayaran,
          'upload_bukti_pembayaran': data.uploadBuktiPembayaran,
          'status': data.status,
          'id_produk': data.detail!.idProduk,
          'jumlah': data.detail!.jumlah,
          'harga': data.detail!.harga,
        }),
      );
      /* if (response.data is String) {
          return DataCartResultApi.fromJson(jsonDecode(response.data));
      }
      return DataCartResultApi.fromJson(response.data); */
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> proseUbah(DataCart data) async {
    try {
      Response response = await dio.post(
        "app/page/data_detail_pemesanan/proses_update.php",
        data: FormData.fromMap({
          'id_pemesanan': data.idPemesanan,
          'tanggal_pemesanan': data.tanggalPemesanan,
          'id_pelanggan': data.idPelanggan,
          'id_ongkir': data.idOngkir,
          'id_bank': data.idBank,
          'tanggal_upload_bukti_pembayaran': data.tanggalUploadBuktiPembayaran,
          'upload_bukti_pembayaran': data.uploadBuktiPembayaran,
          'status': data.status,
        }),
      );
      /* if (response.data is String) {
        return DataCartResultApi.fromJson(jsonDecode(response.data));
      }
      return DataCartResultApi.fromJson(response.data); */
      return DataCartResultApi(
        "berhasil",
        DataCartApiData(),
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesHapus(DataHapus data) async {
    try {
      Response response = await dio.post(
        "app/page/data_detail_pemesanan/proses_hapus.php",
        data: FormData.fromMap({
          'proses': data.getIdHapus(),
        }),
      );
      /* if (response.data is String) {
        return DataCartResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataCartResultApi.fromJson(response.data); */
      return DataCartResultApi(
        "berhasil",
        DataCartApiData(),
      ); */
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesUbah(DataCart data) async {
    try {
      Response response = await dio.post(
        "app/page/data_program_hafalan/proses_update.php",
        data: FormData.fromMap({
          'id_pemesanan': data.idPemesanan,
          'tanggal_pemesanan': data.tanggalPemesanan,
          'id_pelanggan': data.idPelanggan,
          'id_ongkir': data.idOngkir,
          'id_bank': data.idBank,
          'tanggal_upload_bukti_pembayaran': data.tanggalUploadBuktiPembayaran,
          'upload_bukti_pembayaran': data.uploadBuktiPembayaran,
          'status': data.status,
        }),
      );
      /* if (response.data is String) {
        return DataCartResultApi.fromJson(jsonDecode(response.data));
      }
      /* return DataCartResultApi.fromJson(response.data); */
      return DataCartResultApi(
        "berhasil",
        DataCartApiData(),
      ); */
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesSelesai(DataCart data) async {
    try {
      Response response = await dio.post(
        "app/page/data_cart/proses_selesai.php",
        data: FormData.fromMap({
          'id_pemesanan': data.idPemesanan,
          'tanggal_pemesanan': data.tanggalPemesanan,
          'id_pelanggan': data.idPelanggan,
          'id_ongkir': data.idOngkir,
          'id_bank': data.idBank,
          'tanggal_upload_bukti_pembayaran': data.tanggalUploadBuktiPembayaran,
          // 'upload_bukti_pembayaran': data.uploadBuktiPembayaran,
          'status': data.status,
          'file': MultipartFile.fromStream(
            data.file!.openRead() as Stream<List<int>> Function(),
            await data.file!.length(),
            filename:
                "${ConfigGlobal.generateId("UPL")}${data.file!.path.split('/').last}",
          ),
        }),
      );
      /* if (response.data is String) {
          return DataCartResultApi.fromJson(jsonDecode(response.data));
      }
      return DataCartResultApi.fromJson(response.data); */
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
