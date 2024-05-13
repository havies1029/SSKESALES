part of 'jobrealcari_bloc.dart';

abstract class JobRealCariEvents extends Equatable {
	const JobRealCariEvents();

	@override
	List<Object> get props => [];
}

class FetchJobRealCariEvent extends JobRealCariEvents {
	final int hal;
	final String searchText;

	const FetchJobRealCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshJobRealCariEvent extends JobRealCariEvents {
	final int hal;
	final String searchText;

	const RefreshJobRealCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahJobRealCariEvent extends JobRealCariEvents {
	final String recordId;

	const UbahJobRealCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahJobRealCariEvent extends JobRealCariEvents{}
class HapusJobRealCariEvent extends JobRealCariEvents{}
class CloseDialogJobRealCariEvent extends JobRealCariEvents{}
