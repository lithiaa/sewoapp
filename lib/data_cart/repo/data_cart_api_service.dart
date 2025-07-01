import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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
      await dio.post(
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
      await dio.post(
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
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> proseUbah(DataCart data) async {
    try {
      await dio.post(
        "app/page/data_cart/proses_update.php",
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
      print('Sending delete request with ID: ${data.getIdHapus()}');
      
      // Try the primary delete endpoint first
      try {
        final response = await dio.post(
          "app/page/data_cart/proses_hapus.php",
          data: FormData.fromMap({
            'proses': data.getIdHapus(),
            'id_detail_pemesanan': data.getIdHapus(),
          }),
        );
        
        print('Delete response (primary): ${response.data}');
        
        if (response.data != null && response.statusCode == 200) {
          return DataCartResultApi("success", DataCartApiData());
        }
      } catch (e) {
        print('Primary delete endpoint failed: $e');
        
        // Try alternative endpoint
        try {
          final response = await dio.post(
            "app/page/data_detail_pemesanan/proses_hapus.php",
            data: FormData.fromMap({
              'proses': data.getIdHapus(),
              'id_detail_pemesanan': data.getIdHapus(),
            }),
          );
          
          print('Delete response (alternative): ${response.data}');
          
          if (response.data != null && response.statusCode == 200) {
            return DataCartResultApi("success", DataCartApiData());
          }
        } catch (e2) {
          print('Alternative delete endpoint also failed: $e2');
          throw e; // Throw the original error
        }
      }
      
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      print('Delete error: $error');
      print('Delete stacktrace: $stacktrace');
      throw Exception("Failed to delete item: $error");
    }
  }

  Future<DataCartResultApi> updateQuantity(String idProduk, String jumlah, String idPelanggan) async {
    try {
      await dio.post(
        "app/page/data_cart/proses_update.php",
        data: FormData.fromMap({
          'id_produk': idProduk,
          'jumlah': jumlah,
          'id_pelanggan': idPelanggan,
        }),
      );
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesUbah(DataCart data) async {
    try {
      await dio.post(
        "app/page/data_cart/proses_update.php",
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
      return DataCartResultApi("berhasil", DataCartApiData());
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataCartResultApi> prosesSelesai(DataCart data) async {
    try {
      print('Sending payment completion request with data:');
      print('- id_pelanggan: ${data.idPelanggan}');
      print('- id_bank: ${data.idBank}');
      print('- id_ongkir: ${data.idOngkir}');
      print('- file path: ${data.file?.path}');
      
      // Prepare form data
      Map<String, dynamic> formData = {
        'id_pelanggan': data.idPelanggan,
        'id_bank': data.idBank,
        'id_ongkir': data.idOngkir,
        'tanggal_pemesanan': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'status': 'pending',
      };
      
      // Add file if provided
      if (data.file != null) {
        formData['file'] = await MultipartFile.fromFile(
          data.file!.path,
          filename: "${ConfigGlobal.generateId("UPL")}${data.file!.path.split('/').last}",
        );
      }
      
      print('Form data prepared: ${formData.keys.toList()}');
      
      final response = await dio.post(
        "app/page/data_cart/proses_selesai.php",
        data: FormData.fromMap(formData),
      );
      
      print('Payment completion response: ${response.data}');
      
      // Check response
      if (response.data != null) {
        if (response.data is String) {
          final responseMap = jsonDecode(response.data);
          if (responseMap['status'] == 'success' || responseMap['message']?.contains('success') == true) {
            return DataCartResultApi("success", DataCartApiData());
          } else {
            throw Exception("Payment failed: ${responseMap['message'] ?? response.data}");
          }
        } else if (response.data is Map) {
          final responseMap = response.data as Map<String, dynamic>;
          if (responseMap['status'] == 'success' || responseMap['message']?.contains('success') == true) {
            return DataCartResultApi("success", DataCartApiData());
          } else {
            throw Exception("Payment failed: ${responseMap['message'] ?? 'Unknown error'}");
          }
        }
      }
      
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      print('Payment completion error: $error');
      print('Payment completion stacktrace: $stacktrace');
      throw Exception("Payment processing failed: $error");
    }
  }

  Future<DataCartResultApi> prosesSelesaiWithDetails(DataCart data, List<Map<String, dynamic>> detailItems) async {
    try {
      print('Sending rental completion request with data and ${detailItems.length} items:');
      print('- id_pelanggan: ${data.idPelanggan}');
      print('- id_bank: ${data.idBank}');
      print('- id_ongkir: ${data.idOngkir}');
      print('- file path: ${data.file?.path}');
      print('- detail items: $detailItems');
      
      // Prepare form data for main order
      Map<String, dynamic> formData = {
        'id_pelanggan': data.idPelanggan,
        'id_bank': data.idBank,
        'id_ongkir': data.idOngkir,
        'tanggal_pemesanan': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'status': 'pending',
        // Add detail items as JSON string
        'detail_items': jsonEncode(detailItems),
      };
      
      // Add file if provided
      if (data.file != null) {
        formData['file'] = await MultipartFile.fromFile(
          data.file!.path,
          filename: "${ConfigGlobal.generateId("UPL")}${data.file!.path.split('/').last}",
        );
      }
      
      print('Form data prepared: ${formData.keys.toList()}');
      
      final response = await dio.post(
        "app/page/data_cart/proses_selesai.php",
        data: FormData.fromMap(formData),
      );
      
      print('Rental completion response: ${response.data}');
      
      // Check response
      if (response.data != null) {
        if (response.data is String) {
          final responseMap = jsonDecode(response.data);
          if (responseMap['status'] == 'success' || responseMap['message']?.contains('success') == true) {
            return DataCartResultApi("success", DataCartApiData());
          } else {
            throw Exception("Rental failed: ${responseMap['message'] ?? response.data}");
          }
        } else if (response.data is Map) {
          final responseMap = response.data as Map<String, dynamic>;
          if (responseMap['status'] == 'success' || responseMap['message']?.contains('success') == true) {
            return DataCartResultApi("success", DataCartApiData());
          } else {
            throw Exception("Rental failed: ${responseMap['message'] ?? 'Unknown error'}");
          }
        }
      }
      
      return DataCartResultApi("success", DataCartApiData());
    } catch (error, stacktrace) {
      print('Rental completion error: $error');
      print('Rental completion stacktrace: $stacktrace');
      throw Exception("Rental processing failed: $error");
    }
  }
}
