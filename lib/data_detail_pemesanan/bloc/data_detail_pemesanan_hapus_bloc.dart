import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_result_api.dart';
import 'package:sewoapp/data_detail_pemesanan/repo/data_detail_pemesanan_remote.dart';
// import 'package:sewoapp/data_detail_pemesanan/repo/DataDetailPemesananHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataDetailPemesananHapusBloc extends Bloc<DataDetailPemesananHapusEvent, DataDetailPemesananHapusState> {
  DataDetailPemesananRemote remoteRepo = DataDetailPemesananRemote();
  // DataDetailPemesananHapusLocal localRepo = DataDetailPemesananHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataDetailPemesananHapusBloc() : super(DataDetailPemesananHapusInitial()) {
    on<FetchDataDetailPemesananHapus>(((event, emit) async {
      emit(DataDetailPemesananHapusLoading());
      emit(DataDetailPemesananHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataDetailPemesananHapusNoInternet());
        return;
      }
*/
      try {
        final DataDetailPemesananResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataDetailPemesananHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataDetailPemesananHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataDetailPemesananHapusEvent extends Equatable {
  const DataDetailPemesananHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataDetailPemesananHapus extends DataDetailPemesananHapusEvent {
  final DataHapus data;

  const FetchDataDetailPemesananHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataDetailPemesananHapusState extends Equatable {
  const DataDetailPemesananHapusState();

  @override
  List<Object> get props => [];
}

class DataDetailPemesananHapusInitial extends DataDetailPemesananHapusState {}

class DataDetailPemesananHapusLoading extends DataDetailPemesananHapusState {}

class DataDetailPemesananHapusLoadSuccess extends DataDetailPemesananHapusState {
}

class DataDetailPemesananHapusNoInternet extends DataDetailPemesananHapusState {}

class DataDetailPemesananHapusLoadFailure extends DataDetailPemesananHapusState {
  final String pesan;
  const DataDetailPemesananHapusLoadFailure({required this.pesan});
}

