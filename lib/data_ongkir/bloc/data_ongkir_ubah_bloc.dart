import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_api.dart';
import 'package:sewoapp/data_ongkir/repo/data_ongkir_remote.dart';
// import 'package:sewoapp/data_ongkir/repo/DataOngkirUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataOngkirUbahBloc extends Bloc<DataOngkirUbahEvent, DataOngkirUbahState> {
  DataOngkirRemote remoteRepo = DataOngkirRemote();
  // DataOngkirUbahLocal localRepo = DataOngkirUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataOngkirUbahBloc() : super(DataOngkirUbahInitial()) {
    on<FetchDataOngkirUbah>(((event, emit) async {
      emit(DataOngkirUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataOngkirUbahNoInternet());
        return;
      }
      try {
        final DataOngkirApi response = await remoteRepo.getData(event.filter);
        emit(DataOngkirUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataOngkirUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataOngkirUbahEvent extends Equatable {
  const DataOngkirUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataOngkirUbah extends DataOngkirUbahEvent {
  final DataFilter filter;

  const FetchDataOngkirUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataOngkirUbahState extends Equatable {
  const DataOngkirUbahState();

  @override
  List<Object> get props => [];
}

class DataOngkirUbahInitial extends DataOngkirUbahState {}

class DataOngkirUbahLoading extends DataOngkirUbahState {}

class DataOngkirUbahLoadSuccess extends DataOngkirUbahState {
  final DataOngkirApi data;
  const DataOngkirUbahLoadSuccess({required this.data});
}

class DataOngkirUbahNoInternet extends DataOngkirUbahState {}

class DataOngkirUbahLoadFailure extends DataOngkirUbahState {
  final String pesan;
  const DataOngkirUbahLoadFailure({required this.pesan});
}

