part of 'titlecari_bloc.dart';

enum ListStatus { initial, success, failure }

class TitleCariState extends Equatable {

	final ListStatus status;
	final List<TitleCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const TitleCariState(
		{this.status = ListStatus.initial,
		this.items = const <TitleCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const TitleCariState.success(List<TitleCariModel> items)
			: this(status: ListStatus.success, items: items);

	const TitleCariState.failure() : this(status: ListStatus.failure);

	TitleCariState copyWith(
		{List<TitleCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return TitleCariState(
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
