part of 'expiredbysales_bloc.dart';

class ExpiredBySalesState extends Equatable {

	final ListStatus status;
	final List<ExpiredBySalesModel> items;
	final bool hasReachedMax;
	const ExpiredBySalesState(
		{this.status = ListStatus.initial,
		this.items = const <ExpiredBySalesModel>[],
		this.hasReachedMax = false,
		});

	const ExpiredBySalesState.success(List<ExpiredBySalesModel> items)
			: this(status: ListStatus.success, items: items);

	const ExpiredBySalesState.failure() : this(status: ListStatus.failure);

	ExpiredBySalesState copyWith(
		{List<ExpiredBySalesModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return ExpiredBySalesState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
