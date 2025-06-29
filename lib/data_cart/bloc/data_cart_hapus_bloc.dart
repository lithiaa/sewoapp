import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_hapus.dart';
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
/*
      if (!await networkInfo.isConnected) {
        emit(DataCartHapusNoInternet());
        return;
      }
*/
      try {
        print('Starting delete process for item ID: ${event.data.getIdHapus()}');
        await remoteRepo.hapus(event.data);
        print('Delete process completed successfully');
        emit(DataCartHapusLoadSuccess());
      } catch (e) {
        print('Delete process failed: $e');
        debugPrint(e.toString());
        
        // Extract more specific error message
        String errorMessage = "Failed to delete item";
        if (e.toString().contains("Failed to delete item:")) {
          errorMessage = e.toString().replaceAll("Exception: ", "");
        } else if (e.toString().contains("SocketException")) {
          errorMessage = "Network connection error. Please check your internet connection.";
        } else if (e.toString().contains("TimeoutException")) {
          errorMessage = "Request timeout. Please try again.";
        } else {
          errorMessage = "Failed to delete item. Please try again.";
        }
        
        emit(DataCartHapusLoadFailure(pesan: errorMessage));
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

