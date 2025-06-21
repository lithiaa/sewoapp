import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_api.dart';
import 'package:sewoapp/data_satuan/repo/data_satuan_remote.dart';
import 'package:sewoapp/data_satuan/data/data_satuan.dart';
// import 'package:sewoapp/data_satuan/repo/DataSatuanSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataSatuanSimpanBloc extends Bloc<DataSatuanSimpanEvent, DataSatuanSimpanState> {
  DataSatuanRemote remoteRepo = DataSatuanRemote();
  // DataSatuanSimpanLocal localRepo = DataSatuanSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataSatuanSimpanBloc() : super(DataSatuanSimpanInitial()) {
    on<FetchDataSatuanSimpan>(((event, emit) async {
      emit(DataSatuanSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataSatuanSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataSatuanSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataSatuanSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataSatuanSimpanEvent extends Equatable {
  const DataSatuanSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataSatuanSimpan extends DataSatuanSimpanEvent {
  final DataSatuan data;

  const FetchDataSatuanSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataSatuanSimpanState extends Equatable {
  const DataSatuanSimpanState();

  @override
  List<Object> get props => [];
}

class DataSatuanSimpanInitial extends DataSatuanSimpanState {}

class DataSatuanSimpanLoading extends DataSatuanSimpanState {}

class DataSatuanSimpanLoadSuccess extends DataSatuanSimpanState {
}

class DataSatuanSimpanNoInternet extends DataSatuanSimpanState {}

class DataSatuanSimpanLoadFailure extends DataSatuanSimpanState {
  final String pesan;
  const DataSatuanSimpanLoadFailure({required this.pesan});
}

