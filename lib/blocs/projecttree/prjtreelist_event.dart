part of 'prjtreelist_bloc.dart';

abstract class PrjtreeListEvents extends Equatable {
	const PrjtreeListEvents();

	@override
	List<Object> get props => [];
}

class FetchPrjtreeListEvent extends PrjtreeListEvents {}

class RefreshPrjtreeListEvent extends PrjtreeListEvents {
	final int hal;
	final String searchText;

	const RefreshPrjtreeListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahPrjtreeListEvent extends PrjtreeListEvents {
	final String recordId;

	const UbahPrjtreeListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahPrjtreeListEvent extends PrjtreeListEvents{}
class HapusPrjtreeListEvent extends PrjtreeListEvents{}
class CloseDialogPrjtreeListEvent extends PrjtreeListEvents{}

class StartPrjTreeListEvent extends PrjtreeListEvents {
  final String projectId;
  const StartPrjTreeListEvent({required this.projectId});

  @override
  List<Object> get props => [projectId];
}