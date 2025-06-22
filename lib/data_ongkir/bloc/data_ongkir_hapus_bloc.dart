import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_api.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_result_api.dart';
import 'package:sewoapp/data_ongkir/repo/data_ongkir_remote.dart';
// import 'package:sewoapp/data_ongkir/repo/DataOngkirHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataOngkirHapusBloc extends Bloc<DataOngkirHapusEvent, DataOngkirHapusState> {
  DataOngkirRemote remoteRepo = DataOngkirRemote();
  // DataOngkirHapusLocal localRepo = DataOngkirHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataOngkirHapusBloc() : super(DataOngkirHapusInitial()) {
    on<FetchDataOngkirHapus>(((event, emit) async {
      emit(DataOngkirHapusLoading());
      emit(DataOngkirHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataOngkirHapusNoInternet());
        return;
      }
*/
      try {
        final DataOngkirResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataOngkirHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataOngkirHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataOngkirHapusEvent extends Equatable {
  const DataOngkirHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataOngkirHapus extends DataOngkirHapusEvent {
  final DataHapus data;

  const FetchDataOngkirHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataOngkirHapusState extends Equatable {
  const DataOngkirHapusState();

  @override
  List<Object> get props => [];
}

class DataOngkirHapusInitial extends DataOngkirHapusState {}

class DataOngkirHapusLoading extends DataOngkirHapusState {}

class DataOngkirHapusLoadSuccess extends DataOngkirHapusState {
}

class DataOngkirHapusNoInternet extends DataOngkirHapusState {}

class DataOngkirHapusLoadFailure extends DataOngkirHapusState {
  final String pesan;
  const DataOngkirHapusLoadFailure({required this.pesan});
}

