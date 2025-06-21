import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_api.dart';
import 'package:sewoapp/data_pemesanan/repo/data_pemesanan_remote.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan.dart';
// import 'package:sewoapp/data_pemesanan/repo/DataPemesananSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPemesananSimpanBloc extends Bloc<DataPemesananSimpanEvent, DataPemesananSimpanState> {
  DataPemesananRemote remoteRepo = DataPemesananRemote();
  // DataPemesananSimpanLocal localRepo = DataPemesananSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPemesananSimpanBloc() : super(DataPemesananSimpanInitial()) {
    on<FetchDataPemesananSimpan>(((event, emit) async {
      emit(DataPemesananSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataPemesananSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataPemesananSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataPemesananSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPemesananSimpanEvent extends Equatable {
  const DataPemesananSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPemesananSimpan extends DataPemesananSimpanEvent {
  final DataPemesanan data;

  const FetchDataPemesananSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataPemesananSimpanState extends Equatable {
  const DataPemesananSimpanState();

  @override
  List<Object> get props => [];
}

class DataPemesananSimpanInitial extends DataPemesananSimpanState {}

class DataPemesananSimpanLoading extends DataPemesananSimpanState {}

class DataPemesananSimpanLoadSuccess extends DataPemesananSimpanState {
}

class DataPemesananSimpanNoInternet extends DataPemesananSimpanState {}

class DataPemesananSimpanLoadFailure extends DataPemesananSimpanState {
  final String pesan;
  const DataPemesananSimpanLoadFailure({required this.pesan});
}

