part of 'staffcari_bloc.dart';

enum ListStatus { initial, success, failure }

class StaffCariState extends Equatable {

	final ListStatus status;
	final List<StaffCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const StaffCariState(
		{this.status = ListStatus.initial,
		this.items = const <StaffCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const StaffCariState.success(List<StaffCariModel> items)
			: this(status: ListStatus.success, items: items);

	const StaffCariState.failure() : this(status: ListStatus.failure);

	StaffCariState copyWith(
		{List<StaffCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return StaffCariState(
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
