import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_bank/data/data_bank_api.dart';
import 'package:sewoapp/data_bank/data/data_bank_result_api.dart';
import 'package:sewoapp/data_bank/repo/data_bank_api_service.dart';
import 'package:sewoapp/data_bank/data/data_bank.dart';

class DataBankRemote {
  final DataBankApiService _serviceApi = DataBankApiService();


  Future<DataBankApi> getData(DataFilter filter) {
    return _serviceApi.getData(filter);
  }

  Future<DataBankResultApi> simpan(DataBank data) {
    return _serviceApi.prosesSimpan(data);
  }

  Future<DataBankResultApi> hapus(DataHapus data) {
    return _serviceApi.prosesHapus(data);
  }

  Future<DataBankResultApi> ubah(DataBank data) {
    return _serviceApi.prosesUbah(data);
  }
}

