part of 'realgroupcari_bloc.dart';

enum ListStatus { initial, success, failure }

class RealGroupCariState extends Equatable {

	final ListStatus status;
	final List<JobSalesCariModel> items;
	final bool hasReachedMax;
	final int hal;

	const RealGroupCariState(
		{this.status = ListStatus.initial,
		this.items = const <JobSalesCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0});

	const RealGroupCariState.success(List<JobSalesCariModel> items)
			: this(status: ListStatus.success, items: items);

	const RealGroupCariState.failure() : this(status: ListStatus.failure);

	RealGroupCariState copyWith(
		{List<JobSalesCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal}){
		return RealGroupCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal];
}
