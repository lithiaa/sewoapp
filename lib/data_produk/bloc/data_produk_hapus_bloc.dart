import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_produk/data/data_produk_result_api.dart';
import 'package:sewoapp/data_produk/repo/data_produk_remote.dart';
// import 'package:sewoapp/data_produk/repo/DataProdukHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataProdukHapusBloc extends Bloc<DataProdukHapusEvent, DataProdukHapusState> {
  DataProdukRemote remoteRepo = DataProdukRemote();
  // DataProdukHapusLocal localRepo = DataProdukHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataProdukHapusBloc() : super(DataProdukHapusInitial()) {
    on<FetchDataProdukHapus>(((event, emit) async {
      emit(DataProdukHapusLoading());
      emit(DataProdukHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataProdukHapusNoInternet());
        return;
      }
*/
      try {
        final DataProdukResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataProdukHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataProdukHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataProdukHapusEvent extends Equatable {
  const DataProdukHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataProdukHapus extends DataProdukHapusEvent {
  final DataHapus data;

  const FetchDataProdukHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataProdukHapusState extends Equatable {
  const DataProdukHapusState();

  @override
  List<Object> get props => [];
}

class DataProdukHapusInitial extends DataProdukHapusState {}

class DataProdukHapusLoading extends DataProdukHapusState {}

class DataProdukHapusLoadSuccess extends DataProdukHapusState {
}

class DataProdukHapusNoInternet extends DataProdukHapusState {}

class DataProdukHapusLoadFailure extends DataProdukHapusState {
  final String pesan;
  const DataProdukHapusLoadFailure({required this.pesan});
}

