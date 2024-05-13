part of 'jabatancari_bloc.dart';

enum ListStatus { initial, success, failure }

class JabatanCariState extends Equatable {

	final ListStatus status;
	final List<JabatanCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const JabatanCariState(
		{this.status = ListStatus.initial,
		this.items = const <JabatanCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const JabatanCariState.success(List<JabatanCariModel> items)
			: this(status: ListStatus.success, items: items);

	const JabatanCariState.failure() : this(status: ListStatus.failure);

	JabatanCariState copyWith(
		{List<JabatanCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return JabatanCariState(
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
