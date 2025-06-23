part of 'todotimelinecrud_bloc.dart';

abstract class TodoTimelineCrudEvents extends Equatable {
	const TodoTimelineCrudEvents();

	@override
	List<Object> get props => [];
}

class TodoTimelineCrudTambahEvent extends TodoTimelineCrudEvents {
	final TodoTimelineCrudModel record;
	const TodoTimelineCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TodoTimelineCrudUbahEvent extends TodoTimelineCrudEvents {
	final TodoTimelineCrudModel record;
	const TodoTimelineCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TodoTimelineCrudHapusEvent extends TodoTimelineCrudEvents {
	final String recordId;
	const TodoTimelineCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TodoTimelineCrudLihatEvent extends TodoTimelineCrudEvents {
	final String recordId;
	const TodoTimelineCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboJobcatgroupChangedEvent extends TodoTimelineCrudEvents{
	final ComboJobcatgroupModel comboJobcatgroup;
	const ComboJobcatgroupChangedEvent({required this.comboJobcatgroup});

	@override	List<Object> get props => [comboJobcatgroup];
}

class TodoTimelineCrudResetEvent extends TodoTimelineCrudEvents {}
