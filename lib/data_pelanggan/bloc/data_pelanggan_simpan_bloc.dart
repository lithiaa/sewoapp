import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_pelanggan/repo/data_pelanggan_remote.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
// import 'package:sewoapp/data_pelanggan/repo/DataPelangganSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPelangganSimpanBloc extends Bloc<DataPelangganSimpanEvent, DataPelangganSimpanState> {
  DataPelangganRemote remoteRepo = DataPelangganRemote();
  // DataPelangganSimpanLocal localRepo = DataPelangganSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPelangganSimpanBloc() : super(DataPelangganSimpanInitial()) {
    on<FetchDataPelangganSimpan>(((event, emit) async {
      emit(DataPelangganSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataPelangganSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataPelangganSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataPelangganSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPelangganSimpanEvent extends Equatable {
  const DataPelangganSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPelangganSimpan extends DataPelangganSimpanEvent {
  final DataPelanggan data;

  const FetchDataPelangganSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataPelangganSimpanState extends Equatable {
  const DataPelangganSimpanState();

  @override
  List<Object> get props => [];
}

class DataPelangganSimpanInitial extends DataPelangganSimpanState {}

class DataPelangganSimpanLoading extends DataPelangganSimpanState {}

class DataPelangganSimpanLoadSuccess extends DataPelangganSimpanState {
}

class DataPelangganSimpanNoInternet extends DataPelangganSimpanState {}

class DataPelangganSimpanLoadFailure extends DataPelangganSimpanState {
  final String pesan;
  const DataPelangganSimpanLoadFailure({required this.pesan});
}

