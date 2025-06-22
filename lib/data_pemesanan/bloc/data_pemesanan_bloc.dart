import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_api.dart';
import 'package:sewoapp/data_pemesanan/repo/data_pemesanan_remote.dart';
// import 'package:sewoapp/data_pemesanan/repo/DataPemesanan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataPemesananBloc extends Bloc<DataPemesananEvent, DataPemesananState> {
  DataPemesananRemote remoteRepo = DataPemesananRemote();
  // DataPemesananLocal localRepo = DataPemesananLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPemesananBloc() : super(DataPemesananInitial()) {
    on<FetchDataPemesanan>(((event, emit) async {
      emit(DataPemesananLoading());
      if (!await networkInfo.isConnected) {
        emit(DataPemesananNoInternet());
        return;
      }
      try {
        final DataPemesananApi response = await remoteRepo.getData(event.filter);
        emit(DataPemesananLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataPemesananLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataPemesananEvent extends Equatable {
  const DataPemesananEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPemesanan extends DataPemesananEvent {
  final DataFilter filter;

  const FetchDataPemesanan(this.filter);
}

/*
BLOC STATE
*/
abstract class DataPemesananState extends Equatable {
  const DataPemesananState();

  @override
  List<Object> get props => [];
}

class DataPemesananInitial extends DataPemesananState {}

class DataPemesananLoading extends DataPemesananState {}

class DataPemesananLoadSuccess extends DataPemesananState {
  final DataPemesananApi data;
  const DataPemesananLoadSuccess({required this.data});
}

class DataPemesananNoInternet extends DataPemesananState {}

class DataPemesananLoadFailure extends DataPemesananState {
  final String pesan;
  const DataPemesananLoadFailure({required this.pesan});
}

