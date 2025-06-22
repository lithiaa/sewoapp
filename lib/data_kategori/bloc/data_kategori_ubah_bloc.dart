import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_api.dart';
import 'package:sewoapp/data_kategori/repo/data_kategori_remote.dart';
// import 'package:sewoapp/data_kategori/repo/DataKategoriUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataKategoriUbahBloc extends Bloc<DataKategoriUbahEvent, DataKategoriUbahState> {
  DataKategoriRemote remoteRepo = DataKategoriRemote();
  // DataKategoriUbahLocal localRepo = DataKategoriUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataKategoriUbahBloc() : super(DataKategoriUbahInitial()) {
    on<FetchDataKategoriUbah>(((event, emit) async {
      emit(DataKategoriUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataKategoriUbahNoInternet());
        return;
      }
      try {
        final DataKategoriApi response = await remoteRepo.getData(event.filter);
        emit(DataKategoriUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataKategoriUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataKategoriUbahEvent extends Equatable {
  const DataKategoriUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataKategoriUbah extends DataKategoriUbahEvent {
  final DataFilter filter;

  const FetchDataKategoriUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataKategoriUbahState extends Equatable {
  const DataKategoriUbahState();

  @override
  List<Object> get props => [];
}

class DataKategoriUbahInitial extends DataKategoriUbahState {}

class DataKategoriUbahLoading extends DataKategoriUbahState {}

class DataKategoriUbahLoadSuccess extends DataKategoriUbahState {
  final DataKategoriApi data;
  const DataKategoriUbahLoadSuccess({required this.data});
}

class DataKategoriUbahNoInternet extends DataKategoriUbahState {}

class DataKategoriUbahLoadFailure extends DataKategoriUbahState {
  final String pesan;
  const DataKategoriUbahLoadFailure({required this.pesan});
}

