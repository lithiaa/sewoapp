import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_result_api.dart';
import 'package:sewoapp/data_satuan/repo/data_satuan_remote.dart';
// import 'package:sewoapp/data_satuan/repo/DataSatuanHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataSatuanHapusBloc extends Bloc<DataSatuanHapusEvent, DataSatuanHapusState> {
  DataSatuanRemote remoteRepo = DataSatuanRemote();
  // DataSatuanHapusLocal localRepo = DataSatuanHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataSatuanHapusBloc() : super(DataSatuanHapusInitial()) {
    on<FetchDataSatuanHapus>(((event, emit) async {
      emit(DataSatuanHapusLoading());
      emit(DataSatuanHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataSatuanHapusNoInternet());
        return;
      }
*/
      try {
        final DataSatuanResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataSatuanHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataSatuanHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataSatuanHapusEvent extends Equatable {
  const DataSatuanHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataSatuanHapus extends DataSatuanHapusEvent {
  final DataHapus data;

  const FetchDataSatuanHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataSatuanHapusState extends Equatable {
  const DataSatuanHapusState();

  @override
  List<Object> get props => [];
}

class DataSatuanHapusInitial extends DataSatuanHapusState {}

class DataSatuanHapusLoading extends DataSatuanHapusState {}

class DataSatuanHapusLoadSuccess extends DataSatuanHapusState {
}

class DataSatuanHapusNoInternet extends DataSatuanHapusState {}

class DataSatuanHapusLoadFailure extends DataSatuanHapusState {
  final String pesan;
  const DataSatuanHapusLoadFailure({required this.pesan});
}

