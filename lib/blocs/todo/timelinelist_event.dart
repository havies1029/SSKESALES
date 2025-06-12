part of 'timelinelist_bloc.dart';

abstract class TimelineListEvents extends Equatable {
	const TimelineListEvents();

	@override
	List<Object> get props => [];
}

class FetchTimelineListEvent extends TimelineListEvents {}

class RefreshTimelineListEvent extends TimelineListEvents {
	final int hal;
	final String searchText;

	const RefreshTimelineListEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahTimelineListEvent extends TimelineListEvents {
	final String recordId;

	const UbahTimelineListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahTimelineListEvent extends TimelineListEvents{}
class HapusTimelineListEvent extends TimelineListEvents{}
class CloseDialogTimelineListEvent extends TimelineListEvents{}
