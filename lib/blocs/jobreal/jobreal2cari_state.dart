part of 'jobreal2cari_bloc.dart';

enum ListStatus { initial, success, failure }

class JobReal2CariState extends Equatable {

	final ListStatus status;
	final List<JobReal2CariModel> items;
	final bool hasReachedMax;
	const JobReal2CariState(
		{this.status = ListStatus.initial,
		this.items = const <JobReal2CariModel>[],
		this.hasReachedMax = false,
		});

	const JobReal2CariState.success(List<JobReal2CariModel> items)
			: this(status: ListStatus.success, items: items);

	const JobReal2CariState.failure() : this(status: ListStatus.failure);

	JobReal2CariState copyWith(
		{List<JobReal2CariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return JobReal2CariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
