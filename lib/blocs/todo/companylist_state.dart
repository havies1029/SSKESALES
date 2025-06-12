part of 'companylist_bloc.dart';

class CompanyListState extends Equatable {

	final ListStatus status;
	final List<CompanyListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String timeline1Id;
	final String recordId;

	const CompanyListState(
		{this.status = ListStatus.initial,
		this.items = const <CompanyListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.timeline1Id = "",
		this.recordId = ""});

	CompanyListState copyWith(
		{List<CompanyListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? timeline1Id,
		String? recordId}) {
		return CompanyListState(
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
