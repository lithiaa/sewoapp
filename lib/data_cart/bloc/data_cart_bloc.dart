import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_cart/data/data_cart_api.dart';
import 'package:sewoapp/data_cart/repo/data_cart_remote.dart';
// import 'package:sewoapp/data_cart/repo/DataCart_local.dart';
import 'package:sewoapp/utils/network_info.dart';

class DataCartBloc extends Bloc<DataCartEvent, DataCartState> {
  DataCartRemote remoteRepo = DataCartRemote();
  // DataCartLocal localRepo = DataCartLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataCartBloc() : super(DataCartInitial()) {
    on<FetchDataCart>(((event, emit) async {
      emit(DataCartLoading());
      if (!await networkInfo.isConnected) {
        emit(DataCartNoInternet());
        return;
      }
      try {
        final DataCartApi response = await remoteRepo.getData(event.filter);
        emit(DataCartLoadSuccess(data: response));
      } catch (e) {
        debugPrint(e.toString());
        emit(const DataCartLoadFailure(
          pesan:
              "Tidak dapat mengambil data, Pastikan hp terhubung ke internet",
        ));
      }
    }));
  }
}

/*
BLOC EVENT
*/
abstract class DataCartEvent extends Equatable {
  const DataCartEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCart extends DataCartEvent {
  final DataFilter filter;

  const FetchDataCart(this.filter);
}

/*
BLOC STATE
*/
abstract class DataCartState extends Equatable {
  const DataCartState();

  @override
  List<Object> get props => [];
}

class DataCartInitial extends DataCartState {}

class DataCartLoading extends DataCartState {}

class DataCartLoadSuccess extends DataCartState {
  final DataCartApi data;
  const DataCartLoadSuccess({required this.data});
}

class DataCartNoInternet extends DataCartState {}

class DataCartLoadFailure extends DataCartState {
  final String pesan;
  const DataCartLoadFailure({required this.pesan});
}
