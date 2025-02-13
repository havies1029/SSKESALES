part of 'projectlist_filter_cubit.dart';

class ProjectlistFilterState extends Equatable {
  final String rekanId;
  final String searchText;

  const ProjectlistFilterState(
      {this.rekanId = "", this.searchText = ""});

  ProjectlistFilterState copyWith({String? rekanId, String? searchText}) {
    return ProjectlistFilterState(
        rekanId: rekanId ?? this.rekanId,
        searchText: searchText ?? this.searchText);
  }

  @override
  List<Object> get props => [rekanId, searchText];
}
