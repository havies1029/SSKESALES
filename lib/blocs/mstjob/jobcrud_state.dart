part of 'jobcrud_bloc.dart';

class JobCrudState extends Equatable {
  final JobCrudModel? record;
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
  final ComboCustCatModel? comboCustCat;
  final ComboJobcatModel? comboJobCat;
  const JobCrudState({
    this.record,
    this.isLoading = false,
    this.isLoaded = false,
    this.isSaving = false,
    this.isSaved = false,
    this.hasFailure = false,
    this.comboCustCat,
    this.comboJobCat
  });

  JobCrudState copyWith({
    JobCrudModel? record,
    bool? isLoading,
    bool? isLoaded,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,
    ComboJobcatModel? comboJobCat,
    ComboCustCatModel? comboCustCat,
  }) {
    return JobCrudState(
      record: record ?? this.record,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      hasFailure: hasFailure ?? this.hasFailure,
      comboJobCat: comboJobCat ?? this.comboJobCat,
      comboCustCat: comboCustCat ?? this.comboCustCat,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
