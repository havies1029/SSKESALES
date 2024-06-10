part of 'jobcrud_bloc.dart';

abstract class JobCrudEvents extends Equatable {
	const JobCrudEvents();

	@override
	List<Object> get props => [];
}

class JobCrudTambahEvent extends JobCrudEvents {
	final JobCrudModel record;
	const JobCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobCrudUbahEvent extends JobCrudEvents {
	final JobCrudModel record;
	const JobCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobCrudHapusEvent extends JobCrudEvents {
	final String recordId;
	const JobCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class JobCrudLihatEvent extends JobCrudEvents {
	final String recordId;
	const JobCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboJobcatChangedEvent extends JobCrudEvents{
	final ComboJobcatModel comboJobcat;
	const ComboJobcatChangedEvent({required this.comboJobcat});

	@override	List<Object> get props => [comboJobcat];
}

class ComboCustCatChangedEvent extends JobCrudEvents{
	final ComboCustCatModel comboCustCat;
	const ComboCustCatChangedEvent({required this.comboCustCat});

	@override	List<Object> get props => [comboCustCat];
}


