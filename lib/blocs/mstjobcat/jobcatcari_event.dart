part of 'jobcatcari_bloc.dart';

abstract class JobCatCariEvents extends Equatable {
	const JobCatCariEvents();

	@override
	List<Object> get props => [];
}

class FetchJobCatCariEvent extends JobCatCariEvents {
	final int hal;
	final String searchText;

	const FetchJobCatCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshJobCatCariEvent extends JobCatCariEvents {
	final int hal;
	final String searchText;

	const RefreshJobCatCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahJobCatCariEvent extends JobCatCariEvents {
	final String recordId;

	const UbahJobCatCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahJobCatCariEvent extends JobCatCariEvents{}
class HapusJobCatCariEvent extends JobCatCariEvents{}
class CloseDialogJobCatCariEvent extends JobCatCariEvents{}
