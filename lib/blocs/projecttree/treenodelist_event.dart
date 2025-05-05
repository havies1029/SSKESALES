part of 'treenodelist_bloc.dart';

abstract class TreenodeListEvents extends Equatable {
	const TreenodeListEvents();

	@override
	List<Object> get props => [];
}

class FetchTreenodeListEvent extends TreenodeListEvents {}

class RefreshTreenodeListEvent extends TreenodeListEvents {
	final int hal;
	final String prjtree1Id;

	const RefreshTreenodeListEvent({required this.hal, required this.prjtree1Id});

	@override
	List<Object> get props => [hal, prjtree1Id];
}

class UbahTreenodeListEvent extends TreenodeListEvents {
	final String recordId;

	const UbahTreenodeListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahTreenodeListEvent extends TreenodeListEvents{}
class HapusTreenodeListEvent extends TreenodeListEvents{}
class CloseDialogTreenodeListEvent extends TreenodeListEvents{}
