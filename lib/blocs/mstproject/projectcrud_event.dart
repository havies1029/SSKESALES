part of 'projectcrud_bloc.dart';

abstract class ProjectCrudEvents extends Equatable {
	const ProjectCrudEvents();

	@override
	List<Object> get props => [];
}

class ProjectCrudTambahEvent extends ProjectCrudEvents {
	final ProjectCrudModel record;
	const ProjectCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class ProjectCrudUbahEvent extends ProjectCrudEvents {
	final ProjectCrudModel record;
	const ProjectCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class ProjectCrudHapusEvent extends ProjectCrudEvents {
	final String recordId;
	const ProjectCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ProjectCrudLihatEvent extends ProjectCrudEvents {
	final String recordId;
	const ProjectCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboCustomerChangedEvent extends ProjectCrudEvents{
	final ComboCustomerModel comboCustomer;
	const ComboCustomerChangedEvent({required this.comboCustomer});

	@override	List<Object> get props => [comboCustomer];
}

class ComboCobChangedEvent extends ProjectCrudEvents{
	final ComboCobModel comboCob;
	const ComboCobChangedEvent({required this.comboCob});

	@override	List<Object> get props => [comboCob];
}

class ComboMstJobCatChangedEvent extends ProjectCrudEvents{
	final ComboMMstJobcatModel comboMstJobCat;
	const ComboMstJobCatChangedEvent({required this.comboMstJobCat});

	@override	List<Object> get props => [comboMstJobCat];
}

