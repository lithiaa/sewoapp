import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_api.dart';
import 'package:sewoapp/data_pelanggan/repo/data_pelanggan_remote.dart';
// import 'package:sewoapp/data_pelanggan/repo/DataPelanggan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPelangganBloc extends Bloc<DataPelangganEvent, DataPelangganState> {
  DataPelangganRemote remoteRepo = DataPelangganRemote();
  // DataPelangganLocal localRepo = DataPelangganLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPelangganBloc() : super(DataPelangganInitial()) {
    on<FetchDataPelanggan>(((event, emit) async {
      emit(DataPelangganLoading());
      if (!await networkInfo.isConnected) {
        emit(DataPelangganNoInternet());
        return;
      }
      try {
        final DataPelangganApi response = await remoteRepo.getData(event.filter);
        emit(DataPelangganLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPelangganLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPelangganEvent extends Equatable {
  const DataPelangganEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPelanggan extends DataPelangganEvent {
  final DataFilter filter;

  const FetchDataPelanggan(this.filter);
}

/*
BLOC STATE
*/
abstract class DataPelangganState extends Equatable {
  const DataPelangganState();

  @override
  List<Object> get props => [];
}

class DataPelangganInitial extends DataPelangganState {}

class DataPelangganLoading extends DataPelangganState {}

class DataPelangganLoadSuccess extends DataPelangganState {
  final DataPelangganApi data;
  const DataPelangganLoadSuccess({required this.data});
}

class DataPelangganNoInternet extends DataPelangganState {}

class DataPelangganLoadFailure extends DataPelangganState {
  final String pesan;
  const DataPelangganLoadFailure({required this.pesan});
}

