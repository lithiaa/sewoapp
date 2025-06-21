import 'package:equatable/equatable.dart';
import 'package:sewoapp/data/data_filter.dart';

abstract class DataKatalogEvent extends Equatable {
  const DataKatalogEvent();

  @override
  List<Object> get props => [];
}

class FetchDataKatalog extends DataKatalogEvent {
  final FilterKatalog filter;

  const FetchDataKatalog(this.filter);
}
