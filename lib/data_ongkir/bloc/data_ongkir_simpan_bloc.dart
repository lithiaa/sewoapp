import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_ongkir/repo/data_ongkir_remote.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir.dart';
// import 'package:sewoapp/data_ongkir/repo/DataOngkirSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataOngkirSimpanBloc extends Bloc<DataOngkirSimpanEvent, DataOngkirSimpanState> {
  DataOngkirRemote remoteRepo = DataOngkirRemote();
  // DataOngkirSimpanLocal localRepo = DataOngkirSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataOngkirSimpanBloc() : super(DataOngkirSimpanInitial()) {
    on<FetchDataOngkirSimpan>(((event, emit) async {
      emit(DataOngkirSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataOngkirSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataOngkirSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataOngkirSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataOngkirSimpanEvent extends Equatable {
  const DataOngkirSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataOngkirSimpan extends DataOngkirSimpanEvent {
  final DataOngkir data;

  const FetchDataOngkirSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataOngkirSimpanState extends Equatable {
  const DataOngkirSimpanState();

  @override
  List<Object> get props => [];
}

class DataOngkirSimpanInitial extends DataOngkirSimpanState {}

class DataOngkirSimpanLoading extends DataOngkirSimpanState {}

class DataOngkirSimpanLoadSuccess extends DataOngkirSimpanState {
}

class DataOngkirSimpanNoInternet extends DataOngkirSimpanState {}

class DataOngkirSimpanLoadFailure extends DataOngkirSimpanState {
  final String pesan;
  const DataOngkirSimpanLoadFailure({required this.pesan});
}

