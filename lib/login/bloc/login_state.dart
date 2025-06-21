import 'package:equatable/equatable.dart';
import 'package:sewoapp/login/data/login_api.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {}

class LoginGagal extends LoginState {
  final LoginApi data;

  const LoginGagal({required this.data});

  @override
  List<Object> get props => [data];
}

class LoginSuccess extends LoginState {
  final LoginApi data;

  const LoginSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
