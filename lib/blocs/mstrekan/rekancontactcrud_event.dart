part of 'rekancontactcrud_bloc.dart';

abstract class RekanContactCrudEvents extends Equatable {
	const RekanContactCrudEvents();

	@override
	List<Object> get props => [];
}

class RekanContactCrudTambahEvent extends RekanContactCrudEvents {
	final RekanContactCrudModel record;
	const RekanContactCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class RekanContactCrudUbahEvent extends RekanContactCrudEvents {
	final RekanContactCrudModel record;
	const RekanContactCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class RekanContactCrudHapusEvent extends RekanContactCrudEvents {
	final String recordId;
	const RekanContactCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class RekanContactCrudLihatEvent extends RekanContactCrudEvents {
	final String recordId;
	const RekanContactCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}


