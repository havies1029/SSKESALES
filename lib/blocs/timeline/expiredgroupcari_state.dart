part of 'expiredgroupcari_bloc.dart';

class ExpiredGroupCariState extends Equatable {

	final ListStatus status;
	final List<ExpiredGroupCariModel> items;
	final bool hasReachedMax;
	const ExpiredGroupCariState(
		{this.status = ListStatus.initial,
		this.items = const <ExpiredGroupCariModel>[],
		this.hasReachedMax = false,
		});

	const ExpiredGroupCariState.success(List<ExpiredGroupCariModel> items)
			: this(status: ListStatus.success, items: items);

	const ExpiredGroupCariState.failure() : this(status: ListStatus.failure);

	ExpiredGroupCariState copyWith(
		{List<ExpiredGroupCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return ExpiredGroupCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
