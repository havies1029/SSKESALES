part of 'poliscari_bloc.dart';

abstract class PolisCariEvents extends Equatable {
	const PolisCariEvents();

	@override
	List<Object> get props => [];
}

class FetchPolisCariEvent extends PolisCariEvents {
	final int hal;
	final String searchText;

	const FetchPolisCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshPolisCariEvent extends PolisCariEvents {
	final int hal;
	final String searchText;

	const RefreshPolisCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahPolisCariEvent extends PolisCariEvents {
	final String recordId;

	const UbahPolisCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahPolisCariEvent extends PolisCariEvents{}
class HapusPolisCariEvent extends PolisCariEvents{}
class CloseDialogPolisCariEvent extends PolisCariEvents{}
