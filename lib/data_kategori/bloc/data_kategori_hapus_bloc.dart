import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_api.dart';
import 'package:sewoapp/data_kategori/data/data_kategori_result_api.dart';
import 'package:sewoapp/data_kategori/repo/data_kategori_remote.dart';
// import 'package:sewoapp/data_kategori/repo/DataKategoriHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataKategoriHapusBloc extends Bloc<DataKategoriHapusEvent, DataKategoriHapusState> {
  DataKategoriRemote remoteRepo = DataKategoriRemote();
  // DataKategoriHapusLocal localRepo = DataKategoriHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataKategoriHapusBloc() : super(DataKategoriHapusInitial()) {
    on<FetchDataKategoriHapus>(((event, emit) async {
      emit(DataKategoriHapusLoading());
      emit(DataKategoriHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataKategoriHapusNoInternet());
        return;
      }
*/
      try {
        final DataKategoriResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataKategoriHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataKategoriHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataKategoriHapusEvent extends Equatable {
  const DataKategoriHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataKategoriHapus extends DataKategoriHapusEvent {
  final DataHapus data;

  const FetchDataKategoriHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataKategoriHapusState extends Equatable {
  const DataKategoriHapusState();

  @override
  List<Object> get props => [];
}

class DataKategoriHapusInitial extends DataKategoriHapusState {}

class DataKategoriHapusLoading extends DataKategoriHapusState {}

class DataKategoriHapusLoadSuccess extends DataKategoriHapusState {
}

class DataKategoriHapusNoInternet extends DataKategoriHapusState {}

class DataKategoriHapusLoadFailure extends DataKategoriHapusState {
  final String pesan;
  const DataKategoriHapusLoadFailure({required this.pesan});
}

