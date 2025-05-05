part of 'prjtreelist_bloc.dart';

class PrjtreeListState extends Equatable {

	final ListStatus status;
	final List<PrjtreeListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String searchText;
	final String recordId;
  final bool started;
  final bool hasFailure;
  final String errorMsg;

	const PrjtreeListState(
		{this.status = ListStatus.initial,
		this.items = const <PrjtreeListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.searchText = "",
		this.recordId = "",    
    this.started = false,
    this.hasFailure = false,
    this.errorMsg = ""});

	PrjtreeListState copyWith(
		{List<PrjtreeListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? searchText,
		String? recordId,
    bool? started,
    bool? hasFailure,
    String? errorMsg}) {
		return PrjtreeListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			searchText: searchText ?? this.searchText,
			recordId: recordId ?? this.recordId,
      started: started ?? this.started,
      hasFailure: hasFailure ?? this.hasFailure,
      errorMsg: errorMsg ?? this.errorMsg);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, viewMode, 
    recordId, searchText, started, hasFailure, errorMsg];
}
