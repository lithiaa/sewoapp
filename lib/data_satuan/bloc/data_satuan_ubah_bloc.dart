import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_api.dart';
import 'package:sewoapp/data_satuan/repo/data_satuan_remote.dart';
// import 'package:sewoapp/data_satuan/repo/DataSatuanUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataSatuanUbahBloc extends Bloc<DataSatuanUbahEvent, DataSatuanUbahState> {
  DataSatuanRemote remoteRepo = DataSatuanRemote();
  // DataSatuanUbahLocal localRepo = DataSatuanUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataSatuanUbahBloc() : super(DataSatuanUbahInitial()) {
    on<FetchDataSatuanUbah>(((event, emit) async {
      emit(DataSatuanUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataSatuanUbahNoInternet());
        return;
      }
      try {
        final DataSatuanApi response = await remoteRepo.getData(event.filter);
        emit(DataSatuanUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataSatuanUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataSatuanUbahEvent extends Equatable {
  const DataSatuanUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataSatuanUbah extends DataSatuanUbahEvent {
  final DataFilter filter;

  const FetchDataSatuanUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataSatuanUbahState extends Equatable {
  const DataSatuanUbahState();

  @override
  List<Object> get props => [];
}

class DataSatuanUbahInitial extends DataSatuanUbahState {}

class DataSatuanUbahLoading extends DataSatuanUbahState {}

class DataSatuanUbahLoadSuccess extends DataSatuanUbahState {
  final DataSatuanApi data;
  const DataSatuanUbahLoadSuccess({required this.data});
}

class DataSatuanUbahNoInternet extends DataSatuanUbahState {}

class DataSatuanUbahLoadFailure extends DataSatuanUbahState {
  final String pesan;
  const DataSatuanUbahLoadFailure({required this.pesan});
}

