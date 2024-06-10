part of 'eventrenewalcari_bloc.dart';

class EventRenewalCariState extends Equatable {

	final ListStatus status;
	final List<EventRenewalModel> items;
  final bool hasReachedMax;

	const EventRenewalCariState(
		{this.status = ListStatus.initial,
		this.items = const <EventRenewalModel>[],
    this.hasReachedMax = false});

	const EventRenewalCariState.success(List<EventRenewalModel> items)
			: this(status: ListStatus.success, items: items);

	const EventRenewalCariState.failure() : this(status: ListStatus.failure);

	EventRenewalCariState copyWith(
		{List<EventRenewalModel>? items,
      bool? hasReachedMax,
		ListStatus? status}){
		return EventRenewalCariState(
			items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
			status: status ?? this.status);
	}

	@override
	List<Object> get props => [status, items, hasReachedMax];
}
