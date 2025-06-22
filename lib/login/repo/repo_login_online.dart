import 'package:sewoapp/login/data/data_login.dart';
import 'package:sewoapp/login/data/login_api.dart';
import 'package:sewoapp/login/repo/login_apiservice.dart';
import 'package:sewoapp/login/repo/repo_login_interface.dart';

class RepoLoginOnline extends RepoLoginInterface {
  final LoginApiService _serviceApi = LoginApiService();

  @override
  Future<LoginApi> login(DataLogin data) {
    return _serviceApi.login(data);
  }
}
