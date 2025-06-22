import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_cart/repo/data_cart_remote.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
// import 'package:sewoapp/data_cart/repo/DataCartSelesai_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataCartSelesaiBloc
    extends Bloc<DataCartSelesaiEvent, DataCartSelesaiState> {
  DataCartRemote remoteRepo = DataCartRemote();
  // DataCartSelesaiLocal localRepo = DataCartSelesaiLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataCartSelesaiBloc() : super(DataCartSelesaiInitial()) {
    on<FetchDataCartSelesai>(
      (event, emit) async {
        emit(DataCartSelesaiLoading());
        /* if (!await networkInfo.isConnected) {
        emit(DataCartSelesaiNoInternet());
        return;
      } */
        try {
          await remoteRepo.prosesSelesai(event.data);
          emit(DataCartSelesaiLoadSuccess());
        } catch (e) {
          debugPrint(e.toString());
          emit(
            const DataCartSelesaiLoadFailure(
                pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
          );
        }
      },
      transformer: restartable(),
    );
  }
}

/*
BLOC EVENT
*/
abstract class DataCartSelesaiEvent extends Equatable {
  const DataCartSelesaiEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCartSelesai extends DataCartSelesaiEvent {
  final DataCart data;

  const FetchDataCartSelesai(this.data);
}

/*
BLOC STATE
*/
abstract class DataCartSelesaiState extends Equatable {
  const DataCartSelesaiState();

  @override
  List<Object> get props => [];
}

class DataCartSelesaiInitial extends DataCartSelesaiState {}

class DataCartSelesaiLoading extends DataCartSelesaiState {}

class DataCartSelesaiLoadSuccess extends DataCartSelesaiState {}

class DataCartSelesaiNoInternet extends DataCartSelesaiState {}

class DataCartSelesaiLoadFailure extends DataCartSelesaiState {
  final String pesan;
  const DataCartSelesaiLoadFailure({required this.pesan});
}
