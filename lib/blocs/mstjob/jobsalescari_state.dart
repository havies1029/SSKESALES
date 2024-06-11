part of 'jobsalescari_bloc.dart';

enum ListStatus { initial, success, failure }

class JobSalesCariState extends Equatable {

	final ListStatus status;
	final List<JobSalesCariModel> items;
	final bool hasReachedMax;
	final int hal;

	const JobSalesCariState(
		{this.status = ListStatus.initial,
		this.items = const <JobSalesCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0});

	const JobSalesCariState.success(List<JobSalesCariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobSalesCariState.failure() : this(status: ListStatus.failure);

	JobSalesCariState copyWith(
		{List<JobSalesCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal}){
		return JobSalesCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal];
}
