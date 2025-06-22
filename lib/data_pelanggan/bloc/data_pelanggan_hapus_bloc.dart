import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_api.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_result_api.dart';
import 'package:sewoapp/data_pelanggan/repo/data_pelanggan_remote.dart';
// import 'package:sewoapp/data_pelanggan/repo/DataPelangganHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPelangganHapusBloc extends Bloc<DataPelangganHapusEvent, DataPelangganHapusState> {
  DataPelangganRemote remoteRepo = DataPelangganRemote();
  // DataPelangganHapusLocal localRepo = DataPelangganHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPelangganHapusBloc() : super(DataPelangganHapusInitial()) {
    on<FetchDataPelangganHapus>(((event, emit) async {
      emit(DataPelangganHapusLoading());
      emit(DataPelangganHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataPelangganHapusNoInternet());
        return;
      }
*/
      try {
        final DataPelangganResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataPelangganHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPelangganHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPelangganHapusEvent extends Equatable {
  const DataPelangganHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPelangganHapus extends DataPelangganHapusEvent {
  final DataHapus data;

  const FetchDataPelangganHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataPelangganHapusState extends Equatable {
  const DataPelangganHapusState();

  @override
  List<Object> get props => [];
}

class DataPelangganHapusInitial extends DataPelangganHapusState {}

class DataPelangganHapusLoading extends DataPelangganHapusState {}

class DataPelangganHapusLoadSuccess extends DataPelangganHapusState {
}

class DataPelangganHapusNoInternet extends DataPelangganHapusState {}

class DataPelangganHapusLoadFailure extends DataPelangganHapusState {
  final String pesan;
  const DataPelangganHapusLoadFailure({required this.pesan});
}

