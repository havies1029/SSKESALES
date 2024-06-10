part of 'jobgroupcrud_bloc.dart';

abstract class JobGroupCrudEvents extends Equatable {
	const JobGroupCrudEvents();

	@override
	List<Object> get props => [];
}

class JobGroupCrudTambahEvent extends JobGroupCrudEvents {
	final JobGroupCrudModel record;
	const JobGroupCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobGroupCrudUbahEvent extends JobGroupCrudEvents {
	final JobGroupCrudModel record;
	const JobGroupCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobGroupCrudHapusEvent extends JobGroupCrudEvents {
	final String recordId;
	const JobGroupCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class JobGroupCrudLihatEvent extends JobGroupCrudEvents {
	final String recordId;
	const JobGroupCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

