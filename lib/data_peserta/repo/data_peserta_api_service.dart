import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_peserta/data/data_peserta.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_api.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_result_api.dart';
import 'package:sewoapp/utils/awesome_dio_interceptor.dart';

class DataPesertaApiService {
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

  Future<DataPesertaApi> getData(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/tampil.php",
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
        return DataPesertaApi.fromJson(jsonDecode(response.data));
      }
      return DataPesertaApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPesertaResultApi> detail(DataFilter filter) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/detail.php",
        data: FormData.fromMap({'id_peserta': filter.idPeserta}),
      );
      if (response.data is String) {
        return DataPesertaResultApi.fromJson(jsonDecode(response.data));
      }
      return DataPesertaResultApi.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DataPesertaResultApi> proseSimpan(DataPeserta data) async {
    try {
      Response response = await dio.post(
        "app/page/data_peserta/proses_update.php",
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
