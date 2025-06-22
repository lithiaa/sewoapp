import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_api.dart';
import 'package:sewoapp/data_kategori/repo/data_kategori_remote.dart';
// import 'package:sewoapp/data_kategori/repo/DataKategori_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataKategoriBloc extends Bloc<DataKategoriEvent, DataKategoriState> {
  DataKategoriRemote remoteRepo = DataKategoriRemote();
  // DataKategoriLocal localRepo = DataKategoriLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataKategoriBloc() : super(DataKategoriInitial()) {
    on<FetchDataKategori>(((event, emit) async {
      emit(DataKategoriLoading());
      if (!await networkInfo.isConnected) {
        emit(DataKategoriNoInternet());
        return;
      }
      try {
        final DataKategoriApi response = await remoteRepo.getData(event.filter);
        emit(DataKategoriLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataKategoriLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataKategoriEvent extends Equatable {
  const DataKategoriEvent();

  @override
  List<Object> get props => [];
}

class FetchDataKategori extends DataKategoriEvent {
  final DataFilter filter;

  const FetchDataKategori(this.filter);
}

/*
BLOC STATE
*/
abstract class DataKategoriState extends Equatable {
  const DataKategoriState();

  @override
  List<Object> get props => [];
}

class DataKategoriInitial extends DataKategoriState {}

class DataKategoriLoading extends DataKategoriState {}

class DataKategoriLoadSuccess extends DataKategoriState {
  final DataKategoriApi data;
  const DataKategoriLoadSuccess({required this.data});
}

class DataKategoriNoInternet extends DataKategoriState {}

class DataKategoriLoadFailure extends DataKategoriState {
  final String pesan;
  const DataKategoriLoadFailure({required this.pesan});
}

