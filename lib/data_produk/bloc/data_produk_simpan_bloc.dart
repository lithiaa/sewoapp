import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_produk/data/data_produk_api.dart';
import 'package:sewoapp/data_produk/repo/data_produk_remote.dart';
import 'package:sewoapp/data_produk/data/data_produk.dart';
// import 'package:sewoapp/data_produk/repo/DataProdukSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataProdukSimpanBloc extends Bloc<DataProdukSimpanEvent, DataProdukSimpanState> {
  DataProdukRemote remoteRepo = DataProdukRemote();
  // DataProdukSimpanLocal localRepo = DataProdukSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataProdukSimpanBloc() : super(DataProdukSimpanInitial()) {
    on<FetchDataProdukSimpan>(((event, emit) async {
      emit(DataProdukSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataProdukSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataProdukSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataProdukSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataProdukSimpanEvent extends Equatable {
  const DataProdukSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataProdukSimpan extends DataProdukSimpanEvent {
  final DataProduk data;

  const FetchDataProdukSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataProdukSimpanState extends Equatable {
  const DataProdukSimpanState();

  @override
  List<Object> get props => [];
}

class DataProdukSimpanInitial extends DataProdukSimpanState {}

class DataProdukSimpanLoading extends DataProdukSimpanState {}

class DataProdukSimpanLoadSuccess extends DataProdukSimpanState {
}

class DataProdukSimpanNoInternet extends DataProdukSimpanState {}

class DataProdukSimpanLoadFailure extends DataProdukSimpanState {
  final String pesan;
  const DataProdukSimpanLoadFailure({required this.pesan});
}

