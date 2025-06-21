import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/login/bloc/login_event.dart';
import 'package:sewoapp/login/bloc/login_state.dart';
import 'package:sewoapp/login/data/data_login.dart';
import 'package:sewoapp/login/data/login_api.dart';
import 'package:sewoapp/login/repo/repo_login_online.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  RepoLoginOnline repository = RepoLoginOnline();

  LoginBloc() : super(LoginInitial()) {
    on<LoginPost>((event, emit) async {
      emit(LoginLoading());
      try { 
        DataLogin data = event.data;
        final LoginApi response = await repository.login(data);
        if (response.status == 'success') {
          await ConfigSessionManager.getInstance().setSudahLogin(true);
          await ConfigSessionManager.getInstance().setData(response);
          emit(LoginSuccess(data: response));
        } else {
          emit(LoginGagal(data: response));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginError());
      }
    });
  }
}
