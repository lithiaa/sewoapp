import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_admin/data/data_admin_api.dart';
import 'package:sewoapp/data_admin/repo/data_admin_remote.dart';
// import 'package:sewoapp/data_admin/repo/DataAdmin_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataAdminBloc extends Bloc<DataAdminEvent, DataAdminState> {
  DataAdminRemote remoteRepo = DataAdminRemote();
  // DataAdminLocal localRepo = DataAdminLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataAdminBloc() : super(DataAdminInitial()) {
    on<FetchDataAdmin>(((event, emit) async {
      emit(DataAdminLoading());
      if (!await networkInfo.isConnected) {
        emit(DataAdminNoInternet());
        return;
      }
      try {
        final DataAdminApi response = await remoteRepo.getData(event.filter);
        emit(DataAdminLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataAdminLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataAdminEvent extends Equatable {
  const DataAdminEvent();

  @override
  List<Object> get props => [];
}

class FetchDataAdmin extends DataAdminEvent {
  final DataFilter filter;

  const FetchDataAdmin(this.filter);
}

/*
BLOC STATE
*/
abstract class DataAdminState extends Equatable {
  const DataAdminState();

  @override
  List<Object> get props => [];
}

class DataAdminInitial extends DataAdminState {}

class DataAdminLoading extends DataAdminState {}

class DataAdminLoadSuccess extends DataAdminState {
  final DataAdminApi data;
  const DataAdminLoadSuccess({required this.data});
}

class DataAdminNoInternet extends DataAdminState {}

class DataAdminLoadFailure extends DataAdminState {
  final String pesan;
  const DataAdminLoadFailure({required this.pesan});
}

