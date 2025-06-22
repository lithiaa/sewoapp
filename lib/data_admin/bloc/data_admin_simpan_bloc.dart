import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_admin/data/data_admin_api.dart';
import 'package:sewoapp/data_admin/repo/data_admin_remote.dart';
import 'package:sewoapp/data_admin/data/data_admin.dart';
// import 'package:sewoapp/data_admin/repo/DataAdminSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataAdminSimpanBloc extends Bloc<DataAdminSimpanEvent, DataAdminSimpanState> {
  DataAdminRemote remoteRepo = DataAdminRemote();
  // DataAdminSimpanLocal localRepo = DataAdminSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataAdminSimpanBloc() : super(DataAdminSimpanInitial()) {
    on<FetchDataAdminSimpan>(((event, emit) async {
      emit(DataAdminSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataAdminSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataAdminSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataAdminSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataAdminSimpanEvent extends Equatable {
  const DataAdminSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataAdminSimpan extends DataAdminSimpanEvent {
  final DataAdmin data;

  const FetchDataAdminSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataAdminSimpanState extends Equatable {
  const DataAdminSimpanState();

  @override
  List<Object> get props => [];
}

class DataAdminSimpanInitial extends DataAdminSimpanState {}

class DataAdminSimpanLoading extends DataAdminSimpanState {}

class DataAdminSimpanLoadSuccess extends DataAdminSimpanState {
}

class DataAdminSimpanNoInternet extends DataAdminSimpanState {}

class DataAdminSimpanLoadFailure extends DataAdminSimpanState {
  final String pesan;
  const DataAdminSimpanLoadFailure({required this.pesan});
}

