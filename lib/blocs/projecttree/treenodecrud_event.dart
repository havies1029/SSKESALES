part of 'treenodecrud_bloc.dart';

abstract class TreenodeCrudEvents extends Equatable {
	const TreenodeCrudEvents();

	@override
	List<Object> get props => [];
}

class TreenodeCrudTambahEvent extends TreenodeCrudEvents {
	final TreenodeCrudModel record;
	const TreenodeCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TreenodeCrudUbahEvent extends TreenodeCrudEvents {
	final TreenodeCrudModel record;
	const TreenodeCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TreenodeCrudHapusEvent extends TreenodeCrudEvents {
	final String recordId;
	const TreenodeCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TreenodeCrudLihatEvent extends TreenodeCrudEvents {
	final String recordId;
	const TreenodeCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

