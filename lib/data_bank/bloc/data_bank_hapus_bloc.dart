import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
import 'package:sewoapp/data_bank/data/data_bank_result_api.dart';
import 'package:sewoapp/data_bank/repo/data_bank_remote.dart';
// import 'package:sewoapp/data_bank/repo/DataBankHapus_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataBankHapusBloc extends Bloc<DataBankHapusEvent, DataBankHapusState> {
  DataBankRemote remoteRepo = DataBankRemote();
  // DataBankHapusLocal localRepo = DataBankHapusLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataBankHapusBloc() : super(DataBankHapusInitial()) {
    on<FetchDataBankHapus>(((event, emit) async {
      emit(DataBankHapusLoading());
      emit(DataBankHapusLoading());
/*
      if (!await networkInfo.isConnected) {
        emit(DataBankHapusNoInternet());
        return;
      }
*/
      try {
        final DataBankResultApi response =
            await remoteRepo.hapus(event.data);
        emit(DataBankHapusLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataBankHapusLoadFailure(pesan: "Gagal dihapus, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataBankHapusEvent extends Equatable {
  const DataBankHapusEvent();

  @override
  List<Object> get props => [];
}

class FetchDataBankHapus extends DataBankHapusEvent {
  final DataHapus data;

  const FetchDataBankHapus({required this.data});
}

/*
BLOC STATE
*/
abstract class DataBankHapusState extends Equatable {
  const DataBankHapusState();

  @override
  List<Object> get props => [];
}

class DataBankHapusInitial extends DataBankHapusState {}

class DataBankHapusLoading extends DataBankHapusState {}

class DataBankHapusLoadSuccess extends DataBankHapusState {
}

class DataBankHapusNoInternet extends DataBankHapusState {}

class DataBankHapusLoadFailure extends DataBankHapusState {
  final String pesan;
  const DataBankHapusLoadFailure({required this.pesan});
}

