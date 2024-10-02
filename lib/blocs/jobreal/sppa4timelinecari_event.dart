part of 'sppa4timelinecari_bloc.dart';

abstract class SppaCariEvents extends Equatable {
  const SppaCariEvents();

  @override
  List<Object> get props => [];
}

class FetchSppaCariEvent extends SppaCariEvents {  

  const FetchSppaCariEvent();

  @override
  List<Object> get props => [];
}

class RefreshSppaCariEvent extends SppaCariEvents {
  final String jobRealId;
  final String searchText;

  const RefreshSppaCariEvent({required this.jobRealId, required this.searchText});

  @override
  List<Object> get props => [jobRealId, searchText];
}
