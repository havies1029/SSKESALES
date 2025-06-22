part of 'todocompanylist_bloc.dart';

class TodoCompanyListState extends Equatable {

	final ListStatus status;
	final List<TodoCompanyListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String timeline1Id;
	final String recordId;

	const TodoCompanyListState(
		{this.status = ListStatus.initial,
		this.items = const <TodoCompanyListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.timeline1Id = "",
		this.recordId = ""});

	TodoCompanyListState copyWith(
		{List<TodoCompanyListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? timeline1Id,
		String? recordId}) {
		return TodoCompanyListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			timeline1Id: timeline1Id ?? this.timeline1Id,
			recordId: recordId ?? this.recordId);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, viewMode, recordId, timeline1Id];
}
