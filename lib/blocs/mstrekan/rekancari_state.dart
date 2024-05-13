part of 'rekancari_bloc.dart';

enum ListStatus { initial, success, failure }

class RekanCariState extends Equatable {

	final ListStatus status;
	final List<RekanCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const RekanCariState(
		{this.status = ListStatus.initial,
		this.items = const <RekanCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const RekanCariState.success(List<RekanCariModel> items)
			: this(status: ListStatus.success, items: items);

	const RekanCariState.failure() : this(status: ListStatus.failure);

	RekanCariState copyWith(
		{List<RekanCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return RekanCariState(
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
