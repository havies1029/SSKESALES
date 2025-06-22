part of 'todocompanylist_bloc.dart';

abstract class TodoCompanyListEvents extends Equatable {
	const TodoCompanyListEvents();

	@override
	List<Object> get props => [];
}

class FetchTodoCompanyListEvent extends TodoCompanyListEvents {}

class RefreshTodoCompanyListEvent extends TodoCompanyListEvents {
	final int hal;
	final String timeline1Id;

	const RefreshTodoCompanyListEvent({required this.hal, required this.timeline1Id});

	@override
	List<Object> get props => [hal, timeline1Id];
}

class UbahTodoCompanyListEvent extends TodoCompanyListEvents {
	final String recordId;

	const UbahTodoCompanyListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahTodoCompanyListEvent extends TodoCompanyListEvents{}
class HapusTodoCompanyListEvent extends TodoCompanyListEvents{}
class CloseDialogTodoCompanyListEvent extends TodoCompanyListEvents{}
