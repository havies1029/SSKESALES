part of 'treenodelist_bloc.dart';

class TreenodeListState extends Equatable {

	final ListStatus status;
	final List<TreenodeListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String prjtree1Id;
	final String recordId;

	const TreenodeListState(
		{this.status = ListStatus.initial,
		this.items = const <TreenodeListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.prjtree1Id = "",
		this.recordId = ""});

	TreenodeListState copyWith(
		{List<TreenodeListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? prjtree1Id,
		String? recordId}) {
		return TreenodeListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			prjtree1Id: prjtree1Id ?? this.prjtree1Id,
			recordId: recordId ?? this.recordId);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, viewMode, recordId, prjtree1Id];
}
