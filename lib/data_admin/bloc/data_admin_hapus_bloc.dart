import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_admin/data/data_admin_result_api.dart';
import 'package:sewoapp/data_admin/repo/data_admin_remote.dart';
// import 'package:sewoapp/data_admin/repo/DataAdminHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataAdminHapusBloc extends Bloc<DataAdminHapusEvent, DataAdminHapusState> {
  DataAdminRemote remoteRepo = DataAdminRemote();
  // DataAdminHapusLocal localRepo = DataAdminHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataAdminHapusBloc() : super(DataAdminHapusInitial()) {
    on<FetchDataAdminHapus>(((event, emit) async {
      emit(DataAdminHapusLoading());
      emit(DataAdminHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataAdminHapusNoInternet());
        return;
      }
*/
      try {
        final DataAdminResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataAdminHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataAdminHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataAdminHapusEvent extends Equatable {
  const DataAdminHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataAdminHapus extends DataAdminHapusEvent {
  final DataHapus data;

  const FetchDataAdminHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataAdminHapusState extends Equatable {
  const DataAdminHapusState();

  @override
  List<Object> get props => [];
}

class DataAdminHapusInitial extends DataAdminHapusState {}

class DataAdminHapusLoading extends DataAdminHapusState {}

class DataAdminHapusLoadSuccess extends DataAdminHapusState {
}

class DataAdminHapusNoInternet extends DataAdminHapusState {}

class DataAdminHapusLoadFailure extends DataAdminHapusState {
  final String pesan;
  const DataAdminHapusLoadFailure({required this.pesan});
}

