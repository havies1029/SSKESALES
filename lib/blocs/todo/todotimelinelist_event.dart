part of 'todotimelinelist_bloc.dart';

abstract class TodoTimelineListEvents extends Equatable {
  const TodoTimelineListEvents();

  @override
  List<Object> get props => [];
}

class FetchTodoTimelineListEvent extends TodoTimelineListEvents {}

class RefreshTodoTimelineListEvent extends TodoTimelineListEvents {
  final DateTime tgl1;
  final String calendarView;

  const RefreshTodoTimelineListEvent({required this.tgl1, required this.calendarView});

  @override
  List<Object> get props => [tgl1, calendarView];
}

class UbahTodoTimelineListEvent extends TodoTimelineListEvents {
  final String recordId;

  const UbahTodoTimelineListEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class TambahTodoTimelineListEvent extends TodoTimelineListEvents {}

class HapusTodoTimelineListEvent extends TodoTimelineListEvents {}

class CloseDialogTodoTimelineListEvent extends TodoTimelineListEvents {}
