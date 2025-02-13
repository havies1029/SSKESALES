part of 'projectlist_bloc.dart';

abstract class ProjectListEvents extends Equatable {
  const ProjectListEvents();

  @override
  List<Object> get props => [];
}

class FetchProjectListEvent extends ProjectListEvents {}

class RefreshProjectListEvent extends ProjectListEvents {
  final String rekanId;
  final String searchText;

  const RefreshProjectListEvent({required this.rekanId, required this.searchText});

  @override
  List<Object> get props => [rekanId, searchText];
}

class UbahProjectListEvent extends ProjectListEvents {
  final String recordId;

  const UbahProjectListEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class TambahProjectListEvent extends ProjectListEvents {}

class HapusProjectListEvent extends ProjectListEvents {}

class CloseDialogProjectListEvent extends ProjectListEvents {}
