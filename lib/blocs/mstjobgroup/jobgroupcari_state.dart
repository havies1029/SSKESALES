part of 'jobgroupcari_bloc.dart';

class JobGroupCariState extends Equatable {

	final ListStatus status;
	final List<JobGroupCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const JobGroupCariState(
		{this.status = ListStatus.initial,
		this.items = const <JobGroupCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const JobGroupCariState.success(List<JobGroupCariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobGroupCariState.failure() : this(status: ListStatus.failure);

	JobGroupCariState copyWith(
		{List<JobGroupCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return JobGroupCariState(
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
