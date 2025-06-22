import 'package:equatable/equatable.dart';

abstract class LoginFormState extends Equatable {
  const LoginFormState();

  @override
  List<Object> get props => [];
}

class LoginFormWelcome extends LoginFormState {}

class LoginFormLogin extends LoginFormState {}

class LoginFormRegister extends LoginFormState {}
