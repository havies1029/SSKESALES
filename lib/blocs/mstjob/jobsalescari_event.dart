part of 'jobsalescari_bloc.dart';

abstract class JobSalesCariEvents extends Equatable {
	const JobSalesCariEvents();

	@override
	List<Object> get props => [];
}

class FetchJobSalesCariEvent extends JobSalesCariEvents {
	final int hal;
	final String searchText;

	const FetchJobSalesCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshJobSalesCariEvent extends JobSalesCariEvents {
	final int hal;
	final String searchText;

	const RefreshJobSalesCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

