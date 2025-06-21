import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_cart/repo/data_cart_remote.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
// import 'package:sewoapp/data_cart/repo/DataCartSimpan_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataCartSimpanBloc
    extends Bloc<DataCartSimpanEvent, DataCartSimpanState> {
  DataCartRemote remoteRepo = DataCartRemote();
  // DataCartSimpanLocal localRepo = DataCartSimpanLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataCartSimpanBloc() : super(DataCartSimpanInitial()) {
    on<FetchDataCartSimpan>(
      (event, emit) async {
        emit(DataCartSimpanLoading());
        /* if (!await networkInfo.isConnected) {
        emit(DataCartSimpanNoInternet());
        return;
      } */
        try {
          await remoteRepo.prosesAddCart(event.data);
          emit(DataCartSimpanLoadSuccess());
        } catch (e) {
          debugPrint(e.toString());
          emit(
            const DataCartSimpanLoadFailure(
                pesan: "Gagal menyimpan, Pastikan hp terhubung ke internet"),
          );
        }
      },
      transformer: sequential(),
    );
  }
}

/*
BLOC EVENT
*/
abstract class DataCartSimpanEvent extends Equatable {
  const DataCartSimpanEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCartSimpan extends DataCartSimpanEvent {
  final DataCart data;

  const FetchDataCartSimpan(this.data);
}

/*
BLOC STATE
*/
abstract class DataCartSimpanState extends Equatable {
  const DataCartSimpanState();

  @override
  List<Object> get props => [];
}

class DataCartSimpanInitial extends DataCartSimpanState {}

class DataCartSimpanLoading extends DataCartSimpanState {}

class DataCartSimpanLoadSuccess extends DataCartSimpanState {}

class DataCartSimpanNoInternet extends DataCartSimpanState {}

class DataCartSimpanLoadFailure extends DataCartSimpanState {
  final String pesan;
  const DataCartSimpanLoadFailure({required this.pesan});
}
