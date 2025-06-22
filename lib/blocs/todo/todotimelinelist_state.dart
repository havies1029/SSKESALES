part of 'todotimelinelist_bloc.dart';

class TodoTimelineListState extends Equatable {

	final ListStatus status;
	final List<Event> items;
	final bool hasReachedMax;
	final DateTime tgl1;
	final String calendarView;
	final String viewMode;
	final String recordId;

	const TodoTimelineListState(
		{this.status = ListStatus.initial,
		this.items = const <Event>[],
    required this.tgl1,
    required this.calendarView,
		this.hasReachedMax = false,
		this.viewMode = "",
		this.recordId = ""});

	TodoTimelineListState copyWith(
		{List<Event>? items,
		bool? hasReachedMax,
		ListStatus? status,
		DateTime? tgl1,
		String? calendarView,
		String? viewMode,
		String? recordId}) {
		return TodoTimelineListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			tgl1: tgl1 ?? this.tgl1,
			calendarView: calendarView ?? this.calendarView,
			viewMode: viewMode ?? this.viewMode,
			recordId: recordId ?? this.recordId);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, tgl1, calendarView, viewMode, recordId];
}
