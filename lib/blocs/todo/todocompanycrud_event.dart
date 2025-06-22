part of 'todocompanycrud_bloc.dart';

abstract class TodoCompanyCrudEvents extends Equatable {
	const TodoCompanyCrudEvents();

	@override
	List<Object> get props => [];
}

class TodoCompanyCrudTambahEvent extends TodoCompanyCrudEvents {
	final TodoCompanyCrudModel record;
	const TodoCompanyCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TodoCompanyCrudUbahEvent extends TodoCompanyCrudEvents {
	final TodoCompanyCrudModel record;
	const TodoCompanyCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TodoCompanyCrudHapusEvent extends TodoCompanyCrudEvents {
	final String recordId;
	const TodoCompanyCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TodoCompanyCrudLihatEvent extends TodoCompanyCrudEvents {
	final String recordId;
	const TodoCompanyCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboCustomerChangedEvent extends TodoCompanyCrudEvents{
	final ComboCustomerModel comboCustomer;
	const ComboCustomerChangedEvent({required this.comboCustomer});

	@override	List<Object> get props => [comboCustomer];}

