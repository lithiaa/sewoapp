import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_bank/data/data_bank_api.dart';
import 'package:sewoapp/data_bank/repo/data_bank_remote.dart';
import 'package:sewoapp/data_bank/data/data_bank.dart';
// import 'package:sewoapp/data_bank/repo/DataBankSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataBankSimpanBloc extends Bloc<DataBankSimpanEvent, DataBankSimpanState> {
  DataBankRemote remoteRepo = DataBankRemote();
  // DataBankSimpanLocal localRepo = DataBankSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataBankSimpanBloc() : super(DataBankSimpanInitial()) {
    on<FetchDataBankSimpan>(((event, emit) async {
      emit(DataBankSimpanLoading());
      /* if (!await networkInfo.isConnected) {
        emit(DataBankSimpanNoInternet());
        return;
      } */
      try {
        await remoteRepo.simpan(event.data);
        emit(DataBankSimpanLoadSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(
          const DataBankSimpanLoadFailure(pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
        );
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataBankSimpanEvent extends Equatable {
  const DataBankSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataBankSimpan extends DataBankSimpanEvent {
  final DataBank data;

  const FetchDataBankSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataBankSimpanState extends Equatable {
  const DataBankSimpanState();

  @override
  List<Object> get props => [];
}

class DataBankSimpanInitial extends DataBankSimpanState {}

class DataBankSimpanLoading extends DataBankSimpanState {}

class DataBankSimpanLoadSuccess extends DataBankSimpanState {
}

class DataBankSimpanNoInternet extends DataBankSimpanState {}

class DataBankSimpanLoadFailure extends DataBankSimpanState {
  final String pesan;
  const DataBankSimpanLoadFailure({required this.pesan});
}

