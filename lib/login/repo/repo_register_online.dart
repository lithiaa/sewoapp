import 'package:sewoapp/login/data/data_register.dart';
import 'package:sewoapp/login/data/register_api.dart';
import 'package:sewoapp/login/repo/login_apiservice.dart';

class RepoRegisterOnline {
  final LoginApiService _serviceApi = LoginApiService();

  @override
  Future<RegisterApi> register(DataRegister data) {
    return _serviceApi.register(data);
  }
}
