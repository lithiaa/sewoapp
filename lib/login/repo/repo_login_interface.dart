import 'package:sewoapp/login/data/data_login.dart';
import 'package:sewoapp/login/data/login_api.dart';

abstract class RepoLoginInterface {
  Future<LoginApi> login(DataLogin data);
}
