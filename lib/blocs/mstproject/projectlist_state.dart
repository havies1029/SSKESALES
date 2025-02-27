part of 'projectlist_bloc.dart';

class ProjectListState extends Equatable {
  final ListStatus status;
  final List<ProjectListModel> items;
  final bool hasReachedMax;
  final String viewMode;
  final String searchText;
  final String rekanId;
  final String recordId;
  final int hal;
  final bool started;
  final bool hasFailure;
  final String errorMsg;

  const ProjectListState(
      {this.status = ListStatus.initial,
      this.items = const <ProjectListModel>[],
      this.hasReachedMax = false,
      this.viewMode = "",
      this.searchText = "",
      this.rekanId = "",
      this.recordId = "",
      this.hal = 0,
      this.started = false,
      this.hasFailure = false,
      this.errorMsg = ""});

  ProjectListState copyWith(
      {List<ProjectListModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      int? hal,
      String? viewMode,
      String? searchText,
      String? rekanId,
      String? recordId,
      bool? started,
      bool? hasFailure,
      String? errorMsg}) {
    return ProjectListState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        viewMode: viewMode ?? this.viewMode,
        searchText: searchText ?? this.searchText,
        rekanId: rekanId ?? this.rekanId,
        recordId: recordId ?? this.recordId,
        hal: hal ?? this.hal,
        started: started ?? this.started,
        hasFailure: hasFailure ?? this.hasFailure,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object> get props => [
        status,
        items,
        hasReachedMax,
        viewMode,
        rekanId,
        searchText,
        recordId,
        hal,
        started,
        hasFailure,
        errorMsg
      ];
}
