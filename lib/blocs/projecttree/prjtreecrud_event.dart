part of 'prjtreecrud_bloc.dart';

abstract class PrjtreeCrudEvents extends Equatable {
	const PrjtreeCrudEvents();

	@override
	List<Object> get props => [];
}

class PrjtreeCrudTambahEvent extends PrjtreeCrudEvents {
	final PrjtreeCrudModel record;
	const PrjtreeCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class PrjtreeCrudUbahEvent extends PrjtreeCrudEvents {
	final PrjtreeCrudModel record;
	const PrjtreeCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class PrjtreeCrudHapusEvent extends PrjtreeCrudEvents {
	final String recordId;
	const PrjtreeCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class PrjtreeCrudLihatEvent extends PrjtreeCrudEvents {
	final String recordId;
	const PrjtreeCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboCustomerChangedEvent extends PrjtreeCrudEvents{
	final ComboCustomerModel comboCustomer;
	const ComboCustomerChangedEvent({required this.comboCustomer});

	@override	List<Object> get props => [comboCustomer];}

class ComboMMstJobcatChangedEvent extends PrjtreeCrudEvents{
	final ComboMMstJobcatModel comboMMstJobcat;
	const ComboMMstJobcatChangedEvent({required this.comboMMstJobcat});

	@override	List<Object> get props => [comboMMstJobcat];}

