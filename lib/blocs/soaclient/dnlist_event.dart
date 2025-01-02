part of 'dnlist_bloc.dart';

abstract class DnlistEvents extends Equatable {
  const DnlistEvents();

  @override
  List<Object> get props => [];
}

class FetchDnlistEvent extends DnlistEvents {}

class RefreshDnlistEvent extends DnlistEvents {
  final String soaAgingId;
  final String searchText;
  const RefreshDnlistEvent(
      {required this.soaAgingId, required this.searchText});

  @override
  List<Object> get props => [soaAgingId, searchText];
}

class SetSelectedDNEvent extends DnlistEvents {
  final String selectedDNId;

  const SetSelectedDNEvent({required this.selectedDNId});
  
  @override
  List<Object> get props => [selectedDNId];
}
