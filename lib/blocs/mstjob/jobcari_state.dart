part of 'jobcari_bloc.dart';

enum ListStatus { initial, success, failure }

class JobCariState extends Equatable {

	final ListStatus status;
	final List<JobCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const JobCariState(
		{this.status = ListStatus.initial,
		this.items = const <JobCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const JobCariState.success(List<JobCariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobCariState.failure() : this(status: ListStatus.failure);

	JobCariState copyWith(
		{List<JobCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return JobCariState(
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
