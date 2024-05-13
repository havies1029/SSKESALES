part of 'jobrealcrud_bloc.dart';

abstract class JobRealCrudEvents extends Equatable {
	const JobRealCrudEvents();

	@override
	List<Object> get props => [];
}

class JobRealCrudTambahEvent extends JobRealCrudEvents {
	final JobRealCrudModel record;
	const JobRealCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobRealCrudUbahEvent extends JobRealCrudEvents {
	final JobRealCrudModel record;
	const JobRealCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JobRealCrudHapusEvent extends JobRealCrudEvents {
	final String recordId;
	const JobRealCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class JobRealCrudLihatEvent extends JobRealCrudEvents {
	final String recordId;
	const JobRealCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboJobcatChangedEvent extends JobRealCrudEvents{
	final ComboJobcatModel comboJobcat;
	const ComboJobcatChangedEvent({required this.comboJobcat});

	@override	List<Object> get props => [comboJobcat];}

class ComboJobChangedEvent extends JobRealCrudEvents{
	final ComboJobModel comboJob;
	const ComboJobChangedEvent({required this.comboJob});

	@override	List<Object> get props => [comboJob];}

class ComboCustomerChangedEvent extends JobRealCrudEvents{
	final ComboCustomerModel comboCustomer;
	const ComboCustomerChangedEvent({required this.comboCustomer});

	@override	List<Object> get props => [comboCustomer];}

class ComboMediaChangedEvent extends JobRealCrudEvents{
	final ComboMediaModel comboMedia;
	const ComboMediaChangedEvent({required this.comboMedia});

	@override	List<Object> get props => [comboMedia];}

