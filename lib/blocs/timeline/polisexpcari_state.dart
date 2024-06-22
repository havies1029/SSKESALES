part of 'polisexpcari_bloc.dart';

class PolisExpCariState extends Equatable {

	final ListStatus status;
	final List<PolisExpCariModel> items;
	final bool hasReachedMax;
	final int hal;
	const PolisExpCariState(
		{this.status = ListStatus.initial,
		this.items = const <PolisExpCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		});

	const PolisExpCariState.success(List<PolisExpCariModel> items)
			: this(status: ListStatus.success, items: items);

	const PolisExpCariState.failure() : this(status: ListStatus.failure);

	PolisExpCariState copyWith(
		{List<PolisExpCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		}){
		return PolisExpCariState(
			items: items ?? this.items,
			hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status,
			hal: hal ?? this.hal,
			);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax, hal];
}
