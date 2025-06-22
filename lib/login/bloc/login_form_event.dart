import 'package:equatable/equatable.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class ShowWelcome extends LoginFormEvent {}

class ShowRegister extends LoginFormEvent {}

class ShowLogin extends LoginFormEvent {}
