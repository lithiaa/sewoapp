import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_produk/data/data_produk_api.dart';
import 'package:sewoapp/data_produk/repo/data_produk_remote.dart';
// import 'package:sewoapp/data_produk/repo/DataProduk_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataProdukBloc extends Bloc<DataProdukEvent, DataProdukState> {
  DataProdukRemote remoteRepo = DataProdukRemote();
  // DataProdukLocal localRepo = DataProdukLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataProdukBloc() : super(DataProdukInitial()) {
    on<FetchDataProduk>(((event, emit) async {
      emit(DataProdukLoading());
      if (!await networkInfo.isConnected) {
        emit(DataProdukNoInternet());
        return;
      }
      try {
        final DataProdukApi response = await remoteRepo.getData(event.filter);
        emit(DataProdukLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataProdukLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataProdukEvent extends Equatable {
  const DataProdukEvent();

  @override
  List<Object> get props => [];
}

class FetchDataProduk extends DataProdukEvent {
  final DataFilter filter;

  const FetchDataProduk(this.filter);
}

/*
BLOC STATE
*/
abstract class DataProdukState extends Equatable {
  const DataProdukState();

  @override
  List<Object> get props => [];
}

class DataProdukInitial extends DataProdukState {}

class DataProdukLoading extends DataProdukState {}

class DataProdukLoadSuccess extends DataProdukState {
  final DataProdukApi data;
  const DataProdukLoadSuccess({required this.data});
}

class DataProdukNoInternet extends DataProdukState {}

class DataProdukLoadFailure extends DataProdukState {
  final String pesan;
  const DataProdukLoadFailure({required this.pesan});
}

