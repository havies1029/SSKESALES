part of 'plancrud_bloc.dart';

abstract class PlanCrudEvents extends Equatable {
	const PlanCrudEvents();

	@override
	List<Object> get props => [];
}

class PlanCrudTambahEvent extends PlanCrudEvents {
	final PlanCrudModel record;
	const PlanCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class PlanCrudUbahEvent extends PlanCrudEvents {
	final PlanCrudModel record;
	const PlanCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class PlanCrudHapusEvent extends PlanCrudEvents {
	final String recordId;
	const PlanCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class PlanCrudLihatEvent extends PlanCrudEvents {
	final String recordId;
	const PlanCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboMProjectChangedEvent extends PlanCrudEvents{
	final ComboMProjectModel comboMProject;
	const ComboMProjectChangedEvent({required this.comboMProject});

	@override	List<Object> get props => [comboMProject];}

