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

  const FetchRekanCariEvent({required this.rekanTypeId, required this.hal, required this.searchText});

  @override
  List<Object> get props => [hal, searchText];
}

class RefreshRekanCariEvent extends RekanCariEvents {
  final String rekanTypeId;
  final int hal;
  final String searchText;

  const RefreshRekanCariEvent({required this.rekanTypeId, required this.hal, required this.searchText});

  @override
  List<Object> get props => [hal, searchText];
}

class UbahRekanCariEvent extends RekanCariEvents {
  final String recordId;

  const UbahRekanCariEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class TambahRekanCariEvent extends RekanCariEvents {}

class HapusRekanCariEvent extends RekanCariEvents {}

class CloseDialogRekanCariEvent extends RekanCariEvents {}
