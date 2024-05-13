part of 'poliscari_bloc.dart';

enum ListStatus { initial, success, failure }

class PolisCariState extends Equatable {

	final ListStatus status;
	final List<PolisCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const PolisCariState(
		{this.status = ListStatus.initial,
		this.items = const <PolisCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const PolisCariState.success(List<PolisCariModel> items)
			: this(status: ListStatus.success, items: items);

	const PolisCariState.failure() : this(status: ListStatus.failure);

	PolisCariState copyWith(
		{List<PolisCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return PolisCariState(
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
