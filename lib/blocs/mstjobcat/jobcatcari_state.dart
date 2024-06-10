part of 'jobcatcari_bloc.dart';

class JobCatCariState extends Equatable {

	final ListStatus status;
	final List<JobCatCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const JobCatCariState(
		{this.status = ListStatus.initial,
		this.items = const <JobCatCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const JobCatCariState.success(List<JobCatCariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobCatCariState.failure() : this(status: ListStatus.failure);

	JobCatCariState copyWith(
		{List<JobCatCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return JobCatCariState(
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
