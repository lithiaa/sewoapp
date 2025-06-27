import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_peserta/data/data_peserta.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_apidata.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_result_api.dart';
import 'package:sewoapp/data_peserta/repo/data_peserta_remote.dart';
// import 'package:sewoapp/data_peserta/repo/DataPeserta_local.dart';
import 'package:sewoapp/utils/network_info.dart';
import 'package:rxdart/rxdart.dart';

class DataPesertaBloc extends Bloc<DataPesertaEvent, DataPesertaState> {
  DataPesertaRemote remoteRepo = DataPesertaRemote();
  // DataPesertaLocal localRepo = DataPesertaLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataPesertaBloc() : super(DataPesertaInitial()) {
    on<FetchDataPeserta>(
      ((event, emit) async {
        emit(DataPesertaLoading());
        if (!await networkInfo.isConnected) {
          emit(DataPesertaNoInternet());
          return;
        }
        try {
          final DataPesertaResultApi response =
              await remoteRepo.detail(event.filter);
          emit(DataPesertaLoadSuccess(data: response.result!));
        } catch (e) {
          debugPrint(e.toString());
          emit(const DataPesertaLoadFailure(pesan: "Gagal load data!"));
        }
      }),
      transformer: debounce(const Duration(milliseconds: 200)),
    );

    on<SimpanDataPeserta>(
      ((event, emit) async {
        emit(DataPesertaLoading());
        // await Future.delayed(const Duration(milliseconds: 1500));
        if (!await networkInfo.isConnected) {
          emit(DataPesertaNoInternet());
          return;
        }
        try {
          final DataPesertaResultApi response =
              await remoteRepo.prosesSimpan(event.data);
          if (response.status == "gagal") {
            emit(const DataPesertaLoadFailure(pesan: "Proses gagal!"));
            return;
          }
          emit(DataPesertaSimpanSuccess(data: response));
        } catch (e) {
          debugPrint(e.toString());
          emit(const DataPesertaLoadFailure(pesan: "Proses gagal!"));
        }
      }),
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}

/*
BLOC EVENT
*/
abstract class DataPesertaEvent extends Equatable {
  const DataPesertaEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPeserta extends DataPesertaEvent {
  final DataFilter filter;

  const FetchDataPeserta(this.filter);
}

class SimpanDataPeserta extends DataPesertaEvent {
  final DataPeserta data;
  const SimpanDataPeserta({required this.data});
}

/*
BLOC STATE
*/
abstract class DataPesertaState extends Equatable {
  const DataPesertaState();

  @override
  List<Object> get props => [];
}

class DataPesertaSimpanSuccess extends DataPesertaState {
  final DataPesertaResultApi data;
  const DataPesertaSimpanSuccess({required this.data});
}

class DataPesertaInitial extends DataPesertaState {}

class DataPesertaLoading extends DataPesertaState {}

class DataPesertaLoadSuccess extends DataPesertaState {
  final DataPesertaApiData data;
  const DataPesertaLoadSuccess({required this.data});
}

class DataPesertaNoInternet extends DataPesertaState {}

class DataPesertaLoadFailure extends DataPesertaState {
  final String pesan;
  const DataPesertaLoadFailure({required this.pesan});
}
