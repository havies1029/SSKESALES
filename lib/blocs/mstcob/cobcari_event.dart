part of 'cobcari_bloc.dart';

abstract class CobCariEvents extends Equatable {
	const CobCariEvents();

	@override
	List<Object> get props => [];
}

class FetchCobCariEvent extends CobCariEvents {
	final int hal;
	final String searchText;

	const FetchCobCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshCobCariEvent extends CobCariEvents {
	final int hal;
	final String searchText;

	const RefreshCobCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahCobCariEvent extends CobCariEvents {
	final String recordId;

	const UbahCobCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahCobCariEvent extends CobCariEvents{}
class HapusCobCariEvent extends CobCariEvents{}
class CloseDialogCobCariEvent extends CobCariEvents{}
