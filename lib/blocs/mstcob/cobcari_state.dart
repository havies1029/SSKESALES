part of 'cobcari_bloc.dart';

class CobCariState extends Equatable {

	final ListStatus status;
	final List<CobCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const CobCariState(
		{this.status = ListStatus.initial,
		this.items = const <CobCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const CobCariState.success(List<CobCariModel> items)
			: this(status: ListStatus.success, items: items);

	const CobCariState.failure() : this(status: ListStatus.failure);

	CobCariState copyWith(
		{List<CobCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return CobCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			recordId: recordId ?? this.recordId);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, viewMode, recordId];
}
