import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/data_peserta/data/data_peserta.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_result_api.dart';
import 'package:sewoapp/login/data/data_login.dart';
import 'package:sewoapp/login/data/data_register.dart';
import 'package:sewoapp/login/data/login_api.dart';
import 'package:sewoapp/login/data/register_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';
import 'package:sewoapp/config/config_global.dart';

class LoginApiService {
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

  Future<LoginApi> login(DataLogin data) async {
    try {
      Response response = await dio.post(
        "login/login.php",
        data: FormData.fromMap({
          'username': data.username.trim(),
          'password': data.password.trim(),
          'login_sebagai': data.login_sebagai
        }),
      );
      if (response.data is String) {
        return LoginApi.fromJson(jsonDecode(response.data));
      }
      return LoginApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<RegisterApi> register(DataRegister data) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/proses_register.php",
        data: FormData.fromMap({
          'nama': data.nama,
          'nik': data.nik,
          'tempat_lahir': data.tempatLahir,
          'tanggal_lahir': data.tanggalLahir,
          'agama': data.agama,
          'jenis_kelamin': data.jenisKelamin,
          'status_perkawinan': data.statusPerkawinan,
          'username': data.username,
          'password': data.password,
        }),
      );
      if (response.data is String) {
        return RegisterApi.fromJson(jsonDecode(response.data));
      }
      return RegisterApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPesertaResultApi> proseRegister(DataPeserta data) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/proses_simpan.php",
        data: FormData.fromMap({
          'id_peserta': data.idPeserta,
          'nama': data.nama,
          'nip': data.nip,
          'nik': data.nik,
          'tempat_lahir': data.tempatLahir,
          'tanggal_lahir': data.tanggalLahir,
          'agama': data.agama,
          'jenis_kelamin': data.jenisKelamin,
          'status_perkawinan': data.statusPerkawinan,
          'id_pangkat_golongan': data.idPangkatGolongan,
          'id_jabatan': data.idJabatan,
          'nama_jabatan': data.namaJabatan,
          'id_unit_kerja': data.idUnitKerja,
          'id_unit': data.idUnit,
          'alamat_unit_kerja': data.alamatUnitKerja,
          'id_pendidikan': data.idPendidikan,
          'alamat_rumah': data.alamatRumah,
          'no_telepon': data.noTelepon,
          'pekerjaan': data.pekerjaan,
          'kelompok_organisasi': data.kelompokOrganisasi,
          'id_jabatan_dalam_kelompok': data.idJabatanDalamKelompok,
          'id_desa_kelurahan': data.idDesaKelurahan,
          'id_kecamatan': data.idKecamatan,
          'id_kabupaten': data.idKabupaten,
          'id_provinsi': data.idProvinsi,
          'telp_fax': data.telpFax,
          'email': data.email,
          'pengalaman_pelatihan': data.pengalamanPelatihan,
          'keterangan': data.keterangan,
          'status': data.status,
          'username': data.username,
          'password': data.password,
        }),
      );
      if (response.data is String) {
        return DataPesertaResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPesertaResultApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
