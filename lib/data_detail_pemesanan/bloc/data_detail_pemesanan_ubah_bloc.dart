import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_api.dart';
import 'package:sewoapp/data_detail_pemesanan/repo/data_detail_pemesanan_remote.dart';
// import 'package:sewoapp/data_detail_pemesanan/repo/DataDetailPemesananUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataDetailPemesananUbahBloc extends Bloc<DataDetailPemesananUbahEvent, DataDetailPemesananUbahState> {
  DataDetailPemesananRemote remoteRepo = DataDetailPemesananRemote();
  // DataDetailPemesananUbahLocal localRepo = DataDetailPemesananUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataDetailPemesananUbahBloc() : super(DataDetailPemesananUbahInitial()) {
    on<FetchDataDetailPemesananUbah>(((event, emit) async {
      emit(DataDetailPemesananUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataDetailPemesananUbahNoInternet());
        return;
      }
      try {
        final DataDetailPemesananApi response = await remoteRepo.getData(event.filter);
        emit(DataDetailPemesananUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataDetailPemesananUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataDetailPemesananUbahEvent extends Equatable {
  const DataDetailPemesananUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataDetailPemesananUbah extends DataDetailPemesananUbahEvent {
  final DataFilter filter;

  const FetchDataDetailPemesananUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataDetailPemesananUbahState extends Equatable {
  const DataDetailPemesananUbahState();

  @override
  List<Object> get props => [];
}

class DataDetailPemesananUbahInitial extends DataDetailPemesananUbahState {}

class DataDetailPemesananUbahLoading extends DataDetailPemesananUbahState {}

class DataDetailPemesananUbahLoadSuccess extends DataDetailPemesananUbahState {
  final DataDetailPemesananApi data;
  const DataDetailPemesananUbahLoadSuccess({required this.data});
}

class DataDetailPemesananUbahNoInternet extends DataDetailPemesananUbahState {}

class DataDetailPemesananUbahLoadFailure extends DataDetailPemesananUbahState {
  final String pesan;
  const DataDetailPemesananUbahLoadFailure({required this.pesan});
}

