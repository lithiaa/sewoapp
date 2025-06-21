import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoInterface {
  Future<bool> get isConnected;
}

class NetworkInfo implements NetworkInfoInterface {
  @override
  Future<bool> get isConnected =>
      Future.value(InternetConnectionChecker().hasConnection);
}
