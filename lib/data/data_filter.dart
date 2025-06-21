class DataFilter {
  final String berdasarkan;
  final String isi;
  final String limit;
  final String hal;
  final String dari;
  final String sampai;
  final String auth;
  final String idPeserta;

  const DataFilter(
      {this.berdasarkan = "",
      this.isi = "",
      this.limit = "",
      this.hal = "",
      this.dari = "",
      this.sampai = "",
      this.auth = "",
      this.idPeserta = ""});
}

class FilterKatalog extends DataFilter {
  @override
  String berdasarkan;
  @override
  String isi;
  @override
  String limit;
  @override
  String hal;
  @override
  String dari;
  @override
  String sampai;
  @override
  String auth;
  String type;

  FilterKatalog({
    this.berdasarkan = "",
    this.isi = "",
    this.limit = "",
    this.hal = "",
    this.dari = "",
    this.sampai = "",
    this.auth = "",
    this.type = "",
  });
}

class DataPencarian extends DataFilter {
  @override
  String berdasarkan;
  @override
  String isi;
  @override
  String limit;
  @override
  String hal;
  @override
  String dari;
  @override
  String sampai;
  @override
  String auth;
  @override
  String idPeserta;

  DataPencarian(
      {this.berdasarkan = "",
      this.isi = "",
      this.limit = "",
      this.hal = "",
      this.dari = "",
      this.sampai = "",
      this.auth = "",
      this.idPeserta = ""});
}
