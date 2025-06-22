import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_api.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_result_api.dart';
import 'package:sewoapp/data_pemesanan/repo/data_pemesanan_remote.dart';
// import 'package:sewoapp/data_pemesanan/repo/DataPemesananHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPemesananHapusBloc extends Bloc<DataPemesananHapusEvent, DataPemesananHapusState> {
  DataPemesananRemote remoteRepo = DataPemesananRemote();
  // DataPemesananHapusLocal localRepo = DataPemesananHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPemesananHapusBloc() : super(DataPemesananHapusInitial()) {
    on<FetchDataPemesananHapus>(((event, emit) async {
      emit(DataPemesananHapusLoading());
      emit(DataPemesananHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataPemesananHapusNoInternet());
        return;
      }
*/
      try {
        final DataPemesananResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataPemesananHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPemesananHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPemesananHapusEvent extends Equatable {
  const DataPemesananHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPemesananHapus extends DataPemesananHapusEvent {
  final DataHapus data;

  const FetchDataPemesananHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataPemesananHapusState extends Equatable {
  const DataPemesananHapusState();

  @override
  List<Object> get props => [];
}

class DataPemesananHapusInitial extends DataPemesananHapusState {}

class DataPemesananHapusLoading extends DataPemesananHapusState {}

class DataPemesananHapusLoadSuccess extends DataPemesananHapusState {
}

class DataPemesananHapusNoInternet extends DataPemesananHapusState {}

class DataPemesananHapusLoadFailure extends DataPemesananHapusState {
  final String pesan;
  const DataPemesananHapusLoadFailure({required this.pesan});
}

