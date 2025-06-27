import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_kategori/repo/data_kategori_remote.dart';
import 'package:sewoapp/data_kategori/data/data_kategori.dart';
// import 'package:sewoapp/data_kategori/repo/DataKategoriSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataKategoriSimpanBloc extends Bloc<DataKategoriSimpanEvent, DataKategoriSimpanState> {
  DataKategoriRemote remoteRepo = DataKategoriRemote();
  // DataKategoriSimpanLocal localRepo = DataKategoriSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataKategoriSimpanBloc() : super(DataKategoriSimpanInitial()) {
    on<FetchDataKategoriSimpan>(((event, emit) async {
      emit(DataKategoriSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataKategoriSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataKategoriSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataKategoriSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataKategoriSimpanEvent extends Equatable {
  const DataKategoriSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataKategoriSimpan extends DataKategoriSimpanEvent {
  final DataKategori data;

  const FetchDataKategoriSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataKategoriSimpanState extends Equatable {
  const DataKategoriSimpanState();

  @override
  List<Object> get props => [];
}

class DataKategoriSimpanInitial extends DataKategoriSimpanState {}

class DataKategoriSimpanLoading extends DataKategoriSimpanState {}

class DataKategoriSimpanLoadSuccess extends DataKategoriSimpanState {
}

class DataKategoriSimpanNoInternet extends DataKategoriSimpanState {}

class DataKategoriSimpanLoadFailure extends DataKategoriSimpanState {
  final String pesan;
  const DataKategoriSimpanLoadFailure({required this.pesan});
}

