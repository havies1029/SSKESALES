part of 'rekancari_bloc.dart';

abstract class RekanCariEvents extends Equatable {
  const RekanCariEvents();

  @override
  List<Object> get props => [];
}

class FetchRekanCariEvent extends RekanCariEvents {
  final String rekanTypeId;
  final int hal;
  final String searchText;
  final String filterBy;

  const FetchRekanCariEvent(
      {required this.rekanTypeId, required this.hal, required this.searchText, required this.filterBy});

  @override
  List<Object> get props => [hal, searchText, rekanTypeId, filterBy];
}

class RefreshRekanCariEvent extends RekanCariEvents {
  final String rekanTypeId;
  final int hal;
  final String searchText;
  final String filterBy;

  const RefreshRekanCariEvent(
      {required this.rekanTypeId, required this.hal, required this.searchText, required this.filterBy});

  @override
  List<Object> get props => [hal, searchText, filterBy, rekanTypeId];
}

class UbahRekanCariEvent extends RekanCariEvents {
  final String recordId;

  const UbahRekanCariEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class SetFilterRekanCariEvent extends RekanCariEvents {
  final String filterBy;

  const SetFilterRekanCariEvent({required this.filterBy});

  @override
  List<Object> get props => [filterBy];
}

class TambahRekanCariEvent extends RekanCariEvents {}

class HapusRekanCariEvent extends RekanCariEvents {}

class CloseDialogRekanCariEvent extends RekanCariEvents {}
