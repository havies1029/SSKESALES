part of 'mediacari_bloc.dart';

class MediaCariState extends Equatable {

	final ListStatus status;
	final List<MediaCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const MediaCariState(
		{this.status = ListStatus.initial,
		this.items = const <MediaCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const MediaCariState.success(List<MediaCariModel> items)
			: this(status: ListStatus.success, items: items);

	const MediaCariState.failure() : this(status: ListStatus.failure);

	MediaCariState copyWith(
		{List<MediaCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return MediaCariState(
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
