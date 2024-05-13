part of 'jabatancari_bloc.dart';

abstract class JabatanCariEvents extends Equatable {
	const JabatanCariEvents();

	@override
	List<Object> get props => [];
}

class FetchJabatanCariEvent extends JabatanCariEvents {
	final int hal;
	final String searchText;

	const FetchJabatanCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshJabatanCariEvent extends JabatanCariEvents {
	final int hal;
	final String searchText;

	const RefreshJabatanCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahJabatanCariEvent extends JabatanCariEvents {
	final String recordId;

	const UbahJabatanCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahJabatanCariEvent extends JabatanCariEvents{}
class HapusJabatanCariEvent extends JabatanCariEvents{}
class CloseDialogJabatanCariEvent extends JabatanCariEvents{}
