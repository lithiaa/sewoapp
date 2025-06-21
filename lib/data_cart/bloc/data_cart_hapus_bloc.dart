import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_cart/data/data_cart_api.dart';
import 'package:sewoapp/data_cart/data/data_cart_result_api.dart';
import 'package:sewoapp/data_cart/repo/data_cart_remote.dart';
// import 'package:sewoapp/data_cart/repo/DataCartHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataCartHapusBloc extends Bloc<DataCartHapusEvent, DataCartHapusState> {
  DataCartRemote remoteRepo = DataCartRemote();
  // DataCartHapusLocal localRepo = DataCartHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataCartHapusBloc() : super(DataCartHapusInitial()) {
    on<FetchDataCartHapus>(((event, emit) async {
      emit(DataCartHapusLoading());
      emit(DataCartHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataCartHapusNoInternet());
        return;
      }
*/
      try {
        final DataCartResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataCartHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataCartHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataCartHapusEvent extends Equatable {
  const DataCartHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCartHapus extends DataCartHapusEvent {
  final DataHapus data;

  const FetchDataCartHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataCartHapusState extends Equatable {
  const DataCartHapusState();

  @override
  List<Object> get props => [];
}

class DataCartHapusInitial extends DataCartHapusState {}

class DataCartHapusLoading extends DataCartHapusState {}

class DataCartHapusLoadSuccess extends DataCartHapusState {
}

class DataCartHapusNoInternet extends DataCartHapusState {}

class DataCartHapusLoadFailure extends DataCartHapusState {
  final String pesan;
  const DataCartHapusLoadFailure({required this.pesan});
}

