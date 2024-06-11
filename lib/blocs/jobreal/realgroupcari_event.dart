part of 'realgroupcari_bloc.dart';

abstract class RealGroupCariEvents extends Equatable {
	const RealGroupCariEvents();

	@override
	List<Object> get props => [];
}

class FetchRealGroupCariEvent extends RealGroupCariEvents {
	final int hal;
	final String searchText;

	const FetchRealGroupCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshRealGroupCariEvent extends RealGroupCariEvents {
	final int hal;
	final String searchText;

	const RefreshRealGroupCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

