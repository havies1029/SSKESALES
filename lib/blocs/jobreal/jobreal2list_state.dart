part of 'jobreal2list_bloc.dart';

enum ListStatus { initial, success, failure }

class JobReal2ListState extends Equatable {

	final ListStatus status;
	final List<JobReal2CariModel> items;
	final bool hasReachedMax;
	const JobReal2ListState(
		{this.status = ListStatus.initial,
		this.items = const <JobReal2CariModel>[],
		this.hasReachedMax = false,
		});

	const JobReal2ListState.success(List<JobReal2CariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobReal2ListState.failure() : this(status: ListStatus.failure);

	JobReal2ListState copyWith(
		{List<JobReal2CariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return JobReal2ListState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
