import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_api.dart';
import 'package:sewoapp/data_satuan/repo/data_satuan_remote.dart';
// import 'package:sewoapp/data_satuan/repo/DataSatuan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataSatuanBloc extends Bloc<DataSatuanEvent, DataSatuanState> {
  DataSatuanRemote remoteRepo = DataSatuanRemote();
  // DataSatuanLocal localRepo = DataSatuanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataSatuanBloc() : super(DataSatuanInitial()) {
    on<FetchDataSatuan>(((event, emit) async {
      emit(DataSatuanLoading());
      if (!await networkInfo.isConnected) {
        emit(DataSatuanNoInternet());
        return;
      }
      try {
        final DataSatuanApi response = await remoteRepo.getData(event.filter);
        emit(DataSatuanLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataSatuanLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataSatuanEvent extends Equatable {
  const DataSatuanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataSatuan extends DataSatuanEvent {
  final DataFilter filter;

  const FetchDataSatuan(this.filter);
}

/*
BLOC STATE
*/
abstract class DataSatuanState extends Equatable {
  const DataSatuanState();

  @override
  List<Object> get props => [];
}

class DataSatuanInitial extends DataSatuanState {}

class DataSatuanLoading extends DataSatuanState {}

class DataSatuanLoadSuccess extends DataSatuanState {
  final DataSatuanApi data;
  const DataSatuanLoadSuccess({required this.data});
}

class DataSatuanNoInternet extends DataSatuanState {}

class DataSatuanLoadFailure extends DataSatuanState {
  final String pesan;
  const DataSatuanLoadFailure({required this.pesan});
}

