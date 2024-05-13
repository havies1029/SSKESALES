part of 'jobrealcari_bloc.dart';

enum ListStatus { initial, success, failure }

class JobRealCariState extends Equatable {

	final ListStatus status;
	final List<JobRealCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const JobRealCariState(
		{this.status = ListStatus.initial,
		this.items = const <JobRealCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const JobRealCariState.success(List<JobRealCariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobRealCariState.failure() : this(status: ListStatus.failure);

	JobRealCariState copyWith(
		{List<JobRealCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return JobRealCariState(
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
