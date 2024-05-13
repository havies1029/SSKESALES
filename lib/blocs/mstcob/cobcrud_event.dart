part of 'cobcrud_bloc.dart';

abstract class CobCrudEvents extends Equatable {
	const CobCrudEvents();

	@override
	List<Object> get props => [];
}

class CobCrudTambahEvent extends CobCrudEvents {
	final CobCrudModel record;
	const CobCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class CobCrudUbahEvent extends CobCrudEvents {
	final CobCrudModel record;
	const CobCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class CobCrudHapusEvent extends CobCrudEvents {
	final String recordId;
	const CobCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class CobCrudLihatEvent extends CobCrudEvents {
	final String recordId;
	const CobCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

