part of 'jobrealbtnfilter_cubit.dart';

class JobRealBtnFilterState extends Equatable {
  final String filterDoc;

  const JobRealBtnFilterState({this.filterDoc = "all"});

  JobRealBtnFilterState copyWith({
    String? filterDoc }) {
    return JobRealBtnFilterState(
      filterDoc: filterDoc ?? this.filterDoc
    );
  }

  @override
  List<Object> get props => [filterDoc];
}
