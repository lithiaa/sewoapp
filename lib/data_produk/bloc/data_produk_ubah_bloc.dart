import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_produk/data/data_produk_api.dart';
import 'package:sewoapp/data_produk/repo/data_produk_remote.dart';
// import 'package:sewoapp/data_produk/repo/DataProdukUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataProdukUbahBloc extends Bloc<DataProdukUbahEvent, DataProdukUbahState> {
  DataProdukRemote remoteRepo = DataProdukRemote();
  // DataProdukUbahLocal localRepo = DataProdukUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataProdukUbahBloc() : super(DataProdukUbahInitial()) {
    on<FetchDataProdukUbah>(((event, emit) async {
      emit(DataProdukUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataProdukUbahNoInternet());
        return;
      }
      try {
        final DataProdukApi response = await remoteRepo.getData(event.filter);
        emit(DataProdukUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataProdukUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataProdukUbahEvent extends Equatable {
  const DataProdukUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataProdukUbah extends DataProdukUbahEvent {
  final DataFilter filter;

  const FetchDataProdukUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataProdukUbahState extends Equatable {
  const DataProdukUbahState();

  @override
  List<Object> get props => [];
}

class DataProdukUbahInitial extends DataProdukUbahState {}

class DataProdukUbahLoading extends DataProdukUbahState {}

class DataProdukUbahLoadSuccess extends DataProdukUbahState {
  final DataProdukApi data;
  const DataProdukUbahLoadSuccess({required this.data});
}

class DataProdukUbahNoInternet extends DataProdukUbahState {}

class DataProdukUbahLoadFailure extends DataProdukUbahState {
  final String pesan;
  const DataProdukUbahLoadFailure({required this.pesan});
}

