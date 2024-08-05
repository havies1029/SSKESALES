part of 'clientassigncari_bloc.dart';

class ClientAssignCariState extends Equatable {

	final ListStatus status;
	final List<ClientAssignCariModel> items;
	final bool hasReachedMax;
	const ClientAssignCariState(
		{this.status = ListStatus.initial,
		this.items = const <ClientAssignCariModel>[],
		this.hasReachedMax = false,
		});

	const ClientAssignCariState.success(List<ClientAssignCariModel> items)
			: this(status: ListStatus.success, items: items);

	const ClientAssignCariState.failure() : this(status: ListStatus.failure);

	ClientAssignCariState copyWith(
		{List<ClientAssignCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		}){
		return ClientAssignCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
