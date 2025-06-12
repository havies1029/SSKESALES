part of 'timelinecrud_bloc.dart';

abstract class TimelineCrudEvents extends Equatable {
	const TimelineCrudEvents();

	@override
	List<Object> get props => [];
}

class TimelineCrudTambahEvent extends TimelineCrudEvents {
	final TimelineCrudModel record;
	const TimelineCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TimelineCrudUbahEvent extends TimelineCrudEvents {
	final TimelineCrudModel record;
	const TimelineCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TimelineCrudHapusEvent extends TimelineCrudEvents {
	final String recordId;
	const TimelineCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TimelineCrudLihatEvent extends TimelineCrudEvents {
	final String recordId;
	const TimelineCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

