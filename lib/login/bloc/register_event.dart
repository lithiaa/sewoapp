import 'package:equatable/equatable.dart';
import 'package:sewoapp/login/data/data_register.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterPost extends RegisterEvent {
  final DataRegister data;
  const RegisterPost(this.data);
}

