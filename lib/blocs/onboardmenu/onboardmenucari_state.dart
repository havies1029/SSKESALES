part of 'onboardmenucari_bloc.dart';
class OnBoardMenuCariState extends Equatable {

	final ListStatus status;
	final OnBoardMenuCariModel? item;
	const OnBoardMenuCariState(
		{this.status = ListStatus.initial,
		this.item,
		});

	const OnBoardMenuCariState.success(OnBoardMenuCariModel item)
			: this(status: ListStatus.success, item: item);

	const OnBoardMenuCariState.failure() : this(status: ListStatus.failure);

	OnBoardMenuCariState copyWith(
		{OnBoardMenuCariModel? item,
		ListStatus? status,
		}){
		return OnBoardMenuCariState(
			item: item ?? this.item,
			status: status ?? this.status,
			);
	}

	@override
	List<Object> get props => [status];
}
