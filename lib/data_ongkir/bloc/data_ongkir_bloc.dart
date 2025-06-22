import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_api.dart';
import 'package:sewoapp/data_ongkir/repo/data_ongkir_remote.dart';
// import 'package:sewoapp/data_ongkir/repo/DataOngkir_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataOngkirBloc extends Bloc<DataOngkirEvent, DataOngkirState> {
  DataOngkirRemote remoteRepo = DataOngkirRemote();
  // DataOngkirLocal localRepo = DataOngkirLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataOngkirBloc() : super(DataOngkirInitial()) {
    on<FetchDataOngkir>(((event, emit) async {
      emit(DataOngkirLoading());
      if (!await networkInfo.isConnected) {
        emit(DataOngkirNoInternet());
        return;
      }
      try {
        final DataOngkirApi response = await remoteRepo.getData(event.filter);
        emit(DataOngkirLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataOngkirLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataOngkirEvent extends Equatable {
  const DataOngkirEvent();

  @override
  List<Object> get props => [];
}

class FetchDataOngkir extends DataOngkirEvent {
  final DataFilter filter;

  const FetchDataOngkir(this.filter);
}

/*
BLOC STATE
*/
abstract class DataOngkirState extends Equatable {
  const DataOngkirState();

  @override
  List<Object> get props => [];
}

class DataOngkirInitial extends DataOngkirState {}

class DataOngkirLoading extends DataOngkirState {}

class DataOngkirLoadSuccess extends DataOngkirState {
  final DataOngkirApi data;
  const DataOngkirLoadSuccess({required this.data});
}

class DataOngkirNoInternet extends DataOngkirState {}

class DataOngkirLoadFailure extends DataOngkirState {
  final String pesan;
  const DataOngkirLoadFailure({required this.pesan});
}

