part of 'custcatcari_bloc.dart';

class CustCatCariState extends Equatable {

	final ListStatus status;
	final List<CustCatCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const CustCatCariState(
		{this.status = ListStatus.initial,
		this.items = const <CustCatCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const CustCatCariState.success(List<CustCatCariModel> items)
			: this(status: ListStatus.success, items: items);

	const CustCatCariState.failure() : this(status: ListStatus.failure);

	CustCatCariState copyWith(
		{List<CustCatCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return CustCatCariState(
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
