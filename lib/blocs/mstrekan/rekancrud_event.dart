part of 'rekancrud_bloc.dart';

abstract class RekanCrudEvents extends Equatable {
	const RekanCrudEvents();

	@override
	List<Object> get props => [];
}

class RekanCrudTambahEvent extends RekanCrudEvents {
	final RekanCrudModel record;
	const RekanCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class RekanCrudUbahEvent extends RekanCrudEvents {
	final RekanCrudModel record;
	const RekanCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class RekanCrudHapusEvent extends RekanCrudEvents {
	final String recordId;
	const RekanCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class RekanCrudLihatEvent extends RekanCrudEvents {
	final String recordId;
	const RekanCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

