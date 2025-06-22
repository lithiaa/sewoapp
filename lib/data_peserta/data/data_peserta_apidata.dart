import 'package:json_annotation/json_annotation.dart';

part 'data_peserta_apidata.g.dart';

@JsonSerializable()
class DataPesertaApiData {
  DataPesertaApiData({
    this.idPeserta,
    this.nama,
    this.nip,
    this.nik,
    this.tempatLahir,
    this.tanggalLahir,
    this.agama,
    this.jenisKelamin,
    this.statusPerkawinan,
    this.idPangkatGolongan,
    this.pangkatGolongan,
    this.idJabatan,
    this.jabatan,
    this.namaJabatan,
    this.idUnitKerja,
    this.unitKerja,
    this.idUnit,
    this.unit,
    this.alamatUnitKerja,
    this.idPendidikan,
    this.pendidikan,
    this.alamatRumah,
    this.noTelepon,
    this.pekerjaan,
    this.kelompokOrganisasi,
    this.idJabatanDalamKelompok,
    this.jabatanDalamKelompok,
    this.idDesaKelurahan,
    this.desaKelurahan,
    this.idKecamatan,
    this.kecamatan,
    this.idKabupaten,
    this.kabupaten,
    this.idProvinsi,
    this.provinsi,
    this.telpFax,
    this.email,
    this.pengalamanPelatihan,
    this.keterangan,
    this.status,
    this.username,
    this.password,
  });

  @JsonKey(name: "id_peserta")
  final String? idPeserta;
  @JsonKey(name: "nama")
  final String? nama;
  @JsonKey(name: "nip")
  final String? nip;
  @JsonKey(name: "nik")
  final String? nik;
  @JsonKey(name: "tempat_lahir")
  final String? tempatLahir;
  @JsonKey(name: "tanggal_lahir")
  final String? tanggalLahir;
  @JsonKey(name: "agama")
  final String? agama;
  @JsonKey(name: "jenis_kelamin")
  final String? jenisKelamin;
  @JsonKey(name: "status_perkawinan")
  final String? statusPerkawinan;

  @JsonKey(name: "id_pangkat_golongan")
  final String? idPangkatGolongan;

  @JsonKey(name: "pangkat_golongan")
  final String? pangkatGolongan;

  @JsonKey(name: "id_jabatan")
  final String? idJabatan;

  @JsonKey(name: "jabatan")
  final String? jabatan;

  @JsonKey(name: "nama_jabatan")
  final String? namaJabatan;

  @JsonKey(name: "id_unit_kerja")
  final String? idUnitKerja;
  @JsonKey(name: "unit_kerja")
  final String? unitKerja;

  @JsonKey(name: "id_unit")
  final String? idUnit;
  @JsonKey(name: "unit")
  final String? unit;

  @JsonKey(name: "alamat_unit_kerja")
  final String? alamatUnitKerja;
  @JsonKey(name: "id_pendidikan")
  final String? idPendidikan;
  @JsonKey(name: "pendidikan")
  final String? pendidikan;

  @JsonKey(name: "alamat_rumah")
  final String? alamatRumah;
  @JsonKey(name: "no_telepon")
  final String? noTelepon;
  @JsonKey(name: "pekerjaan")
  final String? pekerjaan;
  @JsonKey(name: "kelompok_organisasi")
  final String? kelompokOrganisasi;

  @JsonKey(name: "id_jabatan_dalam_kelompok")
  final String? idJabatanDalamKelompok;
  @JsonKey(name: "jabatan_dalam_kelompok")
  final String? jabatanDalamKelompok;

  @JsonKey(name: "id_desa_kelurahan")
  final String? idDesaKelurahan;
  @JsonKey(name: "desa_kelurahan")
  final String? desaKelurahan;

  @JsonKey(name: "id_kecamatan")
  final String? idKecamatan;
  @JsonKey(name: "kecamatan")
  final String? kecamatan;

  @JsonKey(name: "id_kabupaten")
  final String? idKabupaten;
  @JsonKey(name: "kabupaten")
  final String? kabupaten;

  @JsonKey(name: "id_provinsi")
  final String? idProvinsi;
  @JsonKey(name: "provinsi")
  final String? provinsi;

  @JsonKey(name: "telp_fax")
  final String? telpFax;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "pengalaman_pelatihan")
  final String? pengalamanPelatihan;
  @JsonKey(name: "keterangan")
  final String? keterangan;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "password")
  final String? password;

  factory DataPesertaApiData.fromJson(Map<String, dynamic> json) =>
      _$DataPesertaApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataPesertaApiDataToJson(this);
}
