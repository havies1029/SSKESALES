part of 'aginglist_bloc.dart';

class AginglistState extends Equatable {

	final ListStatus status;
	final List<AginglistModel> items;
	final bool hasReachedMax;
	const AginglistState(
		{this.status = ListStatus.initial,
		this.items = const <AginglistModel>[],
		this.hasReachedMax = false,
		});

	const AginglistState.success(List<AginglistModel> items)
			: this(status: ListStatus.success, items: items);

	const AginglistState.failure() : this(status: ListStatus.failure);

	AginglistState copyWith(
		{List<AginglistModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return AginglistState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
