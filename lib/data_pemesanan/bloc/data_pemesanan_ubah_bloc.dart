import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_api.dart';
import 'package:sewoapp/data_pemesanan/repo/data_pemesanan_remote.dart';
// import 'package:sewoapp/data_pemesanan/repo/DataPemesananUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPemesananUbahBloc extends Bloc<DataPemesananUbahEvent, DataPemesananUbahState> {
  DataPemesananRemote remoteRepo = DataPemesananRemote();
  // DataPemesananUbahLocal localRepo = DataPemesananUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPemesananUbahBloc() : super(DataPemesananUbahInitial()) {
    on<FetchDataPemesananUbah>(((event, emit) async {
      emit(DataPemesananUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataPemesananUbahNoInternet());
        return;
      }
      try {
        final DataPemesananApi response = await remoteRepo.getData(event.filter);
        emit(DataPemesananUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPemesananUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPemesananUbahEvent extends Equatable {
  const DataPemesananUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPemesananUbah extends DataPemesananUbahEvent {
  final DataFilter filter;

  const FetchDataPemesananUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataPemesananUbahState extends Equatable {
  const DataPemesananUbahState();

  @override
  List<Object> get props => [];
}

class DataPemesananUbahInitial extends DataPemesananUbahState {}

class DataPemesananUbahLoading extends DataPemesananUbahState {}

class DataPemesananUbahLoadSuccess extends DataPemesananUbahState {
  final DataPemesananApi data;
  const DataPemesananUbahLoadSuccess({required this.data});
}

class DataPemesananUbahNoInternet extends DataPemesananUbahState {}

class DataPemesananUbahLoadFailure extends DataPemesananUbahState {
  final String pesan;
  const DataPemesananUbahLoadFailure({required this.pesan});
}

