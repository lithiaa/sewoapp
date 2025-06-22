import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_result_api.dart';
import 'package:sewoapp/data_pelanggan/repo/data_pelanggan_remote.dart';
// import 'package:sewoapp/data_pelanggan/repo/DataPelangganUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPelangganUbahBloc
    extends Bloc<DataPelangganUbahEvent, DataPelangganUbahState> {
  DataPelangganRemote remoteRepo = DataPelangganRemote();
  // DataPelangganUbahLocal localRepo = DataPelangganUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPelangganUbahBloc() : super(DataPelangganUbahInitial()) {
    on<FetchDataPelangganUbah>(((event, emit) async {
      emit(DataPelangganUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataPelangganUbahNoInternet());
        return;
      }
      try {
        final DataPelangganResultApi response =
            await remoteRepo.ubah(event.data);
        if (response.status.toLowerCase().contains("success")) {
          emit(DataPelangganUbahLoadSuccess(data: response.result));
        } else {
          emit(const DataPelangganUbahLoadFailure(
            pesan: "Gagal mengubah, Pastikan hp terhubung ke internet (code 1)",
          ));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPelangganUbahLoadFailure(
          pesan: "Gagal mengubah, Pastikan hp terhubung ke internet (code 0)",
        ));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPelangganUbahEvent extends Equatable {
  const DataPelangganUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPelangganUbah extends DataPelangganUbahEvent {
  final DataPelanggan data;

  FetchDataPelangganUbah(this.data);
}

/*
BLOC STATE
*/
abstract class DataPelangganUbahState extends Equatable {
  const DataPelangganUbahState();

  @override
  List<Object> get props => [];
}

class DataPelangganUbahInitial extends DataPelangganUbahState {}

class DataPelangganUbahLoading extends DataPelangganUbahState {}

class DataPelangganUbahLoadSuccess extends DataPelangganUbahState {
  final DataPelangganApiData data;
  const DataPelangganUbahLoadSuccess({required this.data});
}

class DataPelangganUbahNoInternet extends DataPelangganUbahState {}

class DataPelangganUbahLoadFailure extends DataPelangganUbahState {
  final String pesan;
  const DataPelangganUbahLoadFailure({required this.pesan});
}
