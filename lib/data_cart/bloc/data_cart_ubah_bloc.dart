import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_cart/data/data_cart_api.dart';
import 'package:sewoapp/data_cart/repo/data_cart_remote.dart';
// import 'package:sewoapp/data_cart/repo/DataCartUbah_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataCartUbahBloc extends Bloc<DataCartUbahEvent, DataCartUbahState> {
  DataCartRemote remoteRepo = DataCartRemote();
  // DataCartUbahLocal localRepo = DataCartUbahLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataCartUbahBloc() : super(DataCartUbahInitial()) {
    on<FetchDataCartUbah>(((event, emit) async {
      emit(DataCartUbahLoading());
      if (!await networkInfo.isConnected) {
        emit(DataCartUbahNoInternet());
        return;
      }
      try {
        final DataCartApi response = await remoteRepo.getData(event.filter);
        emit(DataCartUbahLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataCartUbahLoadFailure(pesan: "Gagal mengubah, Pastikan hp terhubung ke internet"));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataCartUbahEvent extends Equatable {
  const DataCartUbahEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCartUbah extends DataCartUbahEvent {
  final DataFilter filter;

  const FetchDataCartUbah(this.filter);
}

/*
BLOC STATE
*/
abstract class DataCartUbahState extends Equatable {
  const DataCartUbahState();

  @override
  List<Object> get props => [];
}

class DataCartUbahInitial extends DataCartUbahState {}

class DataCartUbahLoading extends DataCartUbahState {}

class DataCartUbahLoadSuccess extends DataCartUbahState {
  final DataCartApi data;
  const DataCartUbahLoadSuccess({required this.data});
}

class DataCartUbahNoInternet extends DataCartUbahState {}

class DataCartUbahLoadFailure extends DataCartUbahState {
  final String pesan;
  const DataCartUbahLoadFailure({required this.pesan});
}

