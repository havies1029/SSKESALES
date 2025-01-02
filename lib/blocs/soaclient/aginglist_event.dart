part of 'aginglist_bloc.dart';

abstract class AginglistEvents extends Equatable {
	const AginglistEvents();

	@override
	List<Object> get props => [];
}

class FetchAginglistEvent extends AginglistEvents {}

class RefreshAginglistEvent extends AginglistEvents {}

