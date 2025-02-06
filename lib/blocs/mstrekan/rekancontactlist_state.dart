part of 'rekancontactlist_bloc.dart';

class RekanContactListState extends Equatable {

	final ListStatus status;
	final List<RekanContactListModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;
  final String mrekanId;

	const RekanContactListState(
		{this.status = ListStatus.initial,
		this.items = const <RekanContactListModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = "",
		this.mrekanId = ""});

	RekanContactListState copyWith(
		{List<RekanContactListModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId,
		String? mrekanId}) {
		return RekanContactListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			viewMode: viewMode ?? this.viewMode,
			recordId: recordId ?? this.recordId,
			mrekanId: mrekanId ?? this.mrekanId);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal, viewMode, recordId, mrekanId];
}
