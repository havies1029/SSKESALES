part of 'jobcari_bloc.dart';

abstract class JobCariEvents extends Equatable {
  const JobCariEvents();

  @override
  List<Object> get props => [];
}

class FetchJobCariEvent extends JobCariEvents {
  final int hal;
  final String searchText;

  const FetchJobCariEvent({required this.hal, required this.searchText});

  @override
  List<Object> get props => [hal, searchText];
}

class RefreshJobCariEvent extends JobCariEvents {
  final String personId;
  final int hal;
  final String searchText;

  const RefreshJobCariEvent({required this.hal, required this.searchText, required this.personId});

  @override
  List<Object> get props => [hal, searchText];
}

class InitDataJobCariEvent extends JobCariEvents {
  final String personId;

  const InitDataJobCariEvent({required this.personId});

  @override
  List<Object> get props => [personId];
}

class UbahJobCariEvent extends JobCariEvents {
  final String recordId;

  const UbahJobCariEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class TambahJobCariEvent extends JobCariEvents {}

class HapusJobCariEvent extends JobCariEvents {}

class CloseDialogJobCariEvent extends JobCariEvents {}
