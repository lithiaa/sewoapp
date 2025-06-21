import 'package:equatable/equatable.dart';
import 'package:sewoapp/login/data/register_api.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {}

class RegisterGagal extends RegisterState {
  final RegisterApi data;

  const RegisterGagal({required this.data});

  @override
  List<Object> get props => [data];
}

class RegisterSuccess extends RegisterState {
  final RegisterApi data;

  const RegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
