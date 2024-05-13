part of 'jobcatcrud_bloc.dart';

abstract class JobCatCrudEvents extends Equatable {
	const JobCatCrudEvents();

	@override
	List<Object> get props => [];
}

class JobCatCrudTambahEvent extends JobCatCrudEvents {
	final JobCatCrudModel record;
	const JobCatCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobCatCrudUbahEvent extends JobCatCrudEvents {
	final JobCatCrudModel record;
	const JobCatCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobCatCrudHapusEvent extends JobCatCrudEvents {
	final String recordId;
	const JobCatCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class JobCatCrudLihatEvent extends JobCatCrudEvents {
	final String recordId;
	const JobCatCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

