import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_event.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_state.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_api.dart';
import 'package:sewoapp/data_katalog/repo/data_katalog_remote.dart';
import 'package:sewoapp/utils/network_info.dart';
import 'package:rxdart/rxdart.dart';

class DataKatalogBloc extends Bloc<DataKatalogEvent, DataKatalogState> {
  DataKatalogRemote remoteRepo = DataKatalogRemote();

  // DataKatalogLocal localRepo = DataKatalogLocal();
  NetworkInfo networkInfo = NetworkInfo();

  DataKatalogBloc() : super(DataKatalogInitial()) {
    on<FetchDataKatalog>(
      ((event, emit) async {
        emit(DataKatalogLoading());
        // if (!await networkInfo.isConnected) {
        //   emit(DataKatalogNoInternet());
        //   return;
        // }
        try {
          final DataKatalogApi response =
              await remoteRepo.getData(event.filter);
          emit(DataKatalogLoadSuccess(
            data: response,
            type: event.filter.type,
          ));
        } catch (e) {
          debugPrint(e.toString());
          await Future.delayed(const Duration(milliseconds: 2500));
          emit(const DataKatalogLoadFailure(
              pesan: "Gagal load data, cek koneksi internet!"));
        }
      }),
      transformer: sequential(),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

/*
BLOC STATE
*/
