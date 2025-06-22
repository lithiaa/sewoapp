import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_api.dart';
import 'package:sewoapp/data_detail_pemesanan/repo/data_detail_pemesanan_remote.dart';
// import 'package:sewoapp/data_detail_pemesanan/repo/DataDetailPemesanan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataDetailPemesananBloc extends Bloc<DataDetailPemesananEvent, DataDetailPemesananState> {
  DataDetailPemesananRemote remoteRepo = DataDetailPemesananRemote();
  // DataDetailPemesananLocal localRepo = DataDetailPemesananLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataDetailPemesananBloc() : super(DataDetailPemesananInitial()) {
    on<FetchDataDetailPemesanan>(((event, emit) async {
      emit(DataDetailPemesananLoading());
      if (!await networkInfo.isConnected) {
        emit(DataDetailPemesananNoInternet());
        return;
      }
      try {
        final DataDetailPemesananApi response = await remoteRepo.getData(event.filter);
        emit(DataDetailPemesananLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataDetailPemesananLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataDetailPemesananEvent extends Equatable {
  const DataDetailPemesananEvent();

  @override
  List<Object> get props => [];
}

class FetchDataDetailPemesanan extends DataDetailPemesananEvent {
  final DataFilter filter;

  const FetchDataDetailPemesanan(this.filter);
}

/*
BLOC STATE
*/
abstract class DataDetailPemesananState extends Equatable {
  const DataDetailPemesananState();

  @override
  List<Object> get props => [];
}

class DataDetailPemesananInitial extends DataDetailPemesananState {}

class DataDetailPemesananLoading extends DataDetailPemesananState {}

class DataDetailPemesananLoadSuccess extends DataDetailPemesananState {
  final DataDetailPemesananApi data;
  const DataDetailPemesananLoadSuccess({required this.data});
}

class DataDetailPemesananNoInternet extends DataDetailPemesananState {}

class DataDetailPemesananLoadFailure extends DataDetailPemesananState {
  final String pesan;
  const DataDetailPemesananLoadFailure({required this.pesan});
}

