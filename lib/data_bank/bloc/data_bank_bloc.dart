import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_bank/data/data_bank_api.dart';
import 'package:sewoapp/data_bank/repo/data_bank_remote.dart';
// import 'package:sewoapp/data_bank/repo/DataBank_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataBankBloc extends Bloc<DataBankEvent, DataBankState> {
  DataBankRemote remoteRepo = DataBankRemote();
  // DataBankLocal localRepo = DataBankLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataBankBloc() : super(DataBankInitial()) {
    on<FetchDataBank>(((event, emit) async {
      emit(DataBankLoading());
      if (!await networkInfo.isConnected) {
        emit(DataBankNoInternet());
        return;
      }
      try {
        final DataBankApi response = await remoteRepo.getData(event.filter);
        emit(DataBankLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataBankLoadFailure(pesan: "Tidak dapat mengambil data, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataBankEvent extends Equatable {
  const DataBankEvent();

  @override
  List<Object> get props => [];
}

class FetchDataBank extends DataBankEvent {
  final DataFilter filter;

  const FetchDataBank(this.filter);
}

/*
BLOC STATE
*/
abstract class DataBankState extends Equatable {
  const DataBankState();

  @override
  List<Object> get props => [];
}

class DataBankInitial extends DataBankState {}

class DataBankLoading extends DataBankState {}

class DataBankLoadSuccess extends DataBankState {
  final DataBankApi data;
  const DataBankLoadSuccess({required this.data});
}

class DataBankNoInternet extends DataBankState {}

class DataBankLoadFailure extends DataBankState {
  final String pesan;
  const DataBankLoadFailure({required this.pesan});
}

