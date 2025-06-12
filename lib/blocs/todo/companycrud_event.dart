part of 'companycrud_bloc.dart';

abstract class CompanyCrudEvents extends Equatable {
	const CompanyCrudEvents();

	@override
	List<Object> get props => [];
}

class CompanyCrudTambahEvent extends CompanyCrudEvents {
	final CompanyCrudModel record;
	const CompanyCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class CompanyCrudUbahEvent extends CompanyCrudEvents {
	final CompanyCrudModel record;
	const CompanyCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class CompanyCrudHapusEvent extends CompanyCrudEvents {
	final String recordId;
	const CompanyCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class CompanyCrudLihatEvent extends CompanyCrudEvents {
	final String recordId;
	const CompanyCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboCustomerChangedEvent extends CompanyCrudEvents{
	final ComboCustomerModel comboCustomer;
	const ComboCustomerChangedEvent({required this.comboCustomer});

	@override	List<Object> get props => [comboCustomer];}

