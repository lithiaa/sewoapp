import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_bank/data/data_bank_api.dart';
import 'package:sewoapp/data_bank/repo/data_bank_remote.dart';
// import 'package:sewoapp/data_bank/repo/DataBankUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataBankUbahBloc extends Bloc<DataBankUbahEvent, DataBankUbahState> {
  DataBankRemote remoteRepo = DataBankRemote();
  // DataBankUbahLocal localRepo = DataBankUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataBankUbahBloc() : super(DataBankUbahInitial()) {
    on<FetchDataBankUbah>(((event, emit) async {
      emit(DataBankUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataBankUbahNoInternet());
        return;
      }
      try {
        final DataBankApi response = await remoteRepo.getData(event.filter);
        emit(DataBankUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataBankUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataBankUbahEvent extends Equatable {
  const DataBankUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataBankUbah extends DataBankUbahEvent {
  final DataFilter filter;

  const FetchDataBankUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataBankUbahState extends Equatable {
  const DataBankUbahState();

  @override
  List<Object> get props => [];
}

class DataBankUbahInitial extends DataBankUbahState {}

class DataBankUbahLoading extends DataBankUbahState {}

class DataBankUbahLoadSuccess extends DataBankUbahState {
  final DataBankApi data;
  const DataBankUbahLoadSuccess({required this.data});
}

class DataBankUbahNoInternet extends DataBankUbahState {}

class DataBankUbahLoadFailure extends DataBankUbahState {
  final String pesan;
  const DataBankUbahLoadFailure({required this.pesan});
}

