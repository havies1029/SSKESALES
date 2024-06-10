part of 'jobgroupcari_bloc.dart';

abstract class JobGroupCariEvents extends Equatable {
	const JobGroupCariEvents();

	@override
	List<Object> get props => [];
}

class FetchJobGroupCariEvent extends JobGroupCariEvents {
	final int hal;
	final String searchText;

	const FetchJobGroupCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshJobGroupCariEvent extends JobGroupCariEvents {
	final int hal;
	final String searchText;

	const RefreshJobGroupCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahJobGroupCariEvent extends JobGroupCariEvents {
	final String recordId;

	const UbahJobGroupCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahJobGroupCariEvent extends JobGroupCariEvents{}
class HapusJobGroupCariEvent extends JobGroupCariEvents{}
class CloseDialogJobGroupCariEvent extends JobGroupCariEvents{}
