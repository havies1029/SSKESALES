part of 'jobreal3grid_bloc.dart';

class JobReal3GridState extends Equatable {

	final ListStatus status;
	final List<JobReal3CariModel> items;
	final bool hasReachedMax;
	const JobReal3GridState(
		{this.status = ListStatus.initial,
		this.items = const <JobReal3CariModel>[],
		this.hasReachedMax = false,
		});

	const JobReal3GridState.success(List<JobReal3CariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobReal3GridState.failure() : this(status: ListStatus.failure);

	JobReal3GridState copyWith(
		{List<JobReal3CariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return JobReal3GridState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
