part of 'poliscrud_bloc.dart';

abstract class PolisCrudEvents extends Equatable {
	const PolisCrudEvents();

	@override
	List<Object> get props => [];
}

class PolisCrudTambahEvent extends PolisCrudEvents {
	final PolisCrudModel record;
	const PolisCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class PolisCrudUbahEvent extends PolisCrudEvents {
	final PolisCrudModel record;
	const PolisCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class PolisCrudHapusEvent extends PolisCrudEvents {
	final String recordId;
	const PolisCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class PolisCrudLihatEvent extends PolisCrudEvents {
	final String recordId;
	const PolisCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboCobChangedEvent extends PolisCrudEvents{
	final ComboCobModel comboCob;
	const ComboCobChangedEvent({required this.comboCob});

	@override	List<Object> get props => [comboCob];}

class ComboCustomerChangedEvent extends PolisCrudEvents{
	final ComboCustomerModel comboCustomer;
	const ComboCustomerChangedEvent({required this.comboCustomer});

	@override	List<Object> get props => [comboCustomer];}

