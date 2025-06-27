import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_detail_pemesanan/repo/data_detail_pemesanan_remote.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';
// import 'package:sewoapp/data_detail_pemesanan/repo/DataDetailPemesananSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataDetailPemesananSimpanBloc extends Bloc<DataDetailPemesananSimpanEvent, DataDetailPemesananSimpanState> {
  DataDetailPemesananRemote remoteRepo = DataDetailPemesananRemote();
  // DataDetailPemesananSimpanLocal localRepo = DataDetailPemesananSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataDetailPemesananSimpanBloc() : super(DataDetailPemesananSimpanInitial()) {
    on<FetchDataDetailPemesananSimpan>(((event, emit) async {
      emit(DataDetailPemesananSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataDetailPemesananSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataDetailPemesananSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataDetailPemesananSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataDetailPemesananSimpanEvent extends Equatable {
  const DataDetailPemesananSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataDetailPemesananSimpan extends DataDetailPemesananSimpanEvent {
  final DataDetailPemesanan data;

  const FetchDataDetailPemesananSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataDetailPemesananSimpanState extends Equatable {
  const DataDetailPemesananSimpanState();

  @override
  List<Object> get props => [];
}

class DataDetailPemesananSimpanInitial extends DataDetailPemesananSimpanState {}

class DataDetailPemesananSimpanLoading extends DataDetailPemesananSimpanState {}

class DataDetailPemesananSimpanLoadSuccess extends DataDetailPemesananSimpanState {
}

class DataDetailPemesananSimpanNoInternet extends DataDetailPemesananSimpanState {}

class DataDetailPemesananSimpanLoadFailure extends DataDetailPemesananSimpanState {
  final String pesan;
  const DataDetailPemesananSimpanLoadFailure({required this.pesan});
}

