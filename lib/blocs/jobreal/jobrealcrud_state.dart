part of 'jobrealcrud_bloc.dart';

class JobRealCrudState extends Equatable {
  final JobRealCrudModel? record;
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
  final ComboJobcatModel? comboJobCat;
  final ComboJobModel? comboJob;
  final ComboMediaModel? comboMedia;
  final ComboCustomerModel? comboCustomer;
  const JobRealCrudState(
      {this.record,
      this.isLoading = false,
      this.isLoaded = false,
      this.isSaving = false,
      this.isSaved = false,
      this.hasFailure = false,
      this.comboJobCat,
      this.comboJob,
      this.comboMedia,
      this.comboCustomer});

  JobRealCrudState copyWith(
      {JobRealCrudModel? record,
      bool? isLoading,
      bool? isLoaded,
      bool? isSaving,
      bool? isSaved,
      bool? hasFailure,
      ComboJobcatModel? comboJobCat,
      ComboJobModel? comboJob,
      ComboMediaModel? comboMedia,
      ComboCustomerModel? comboCustomer}) {
    return JobRealCrudState(
        record: record ?? this.record,
        isLoading: isLoading ?? this.isLoading,
        isLoaded: isLoaded ?? this.isLoaded,
        isSaving: isSaving ?? this.isSaving,
        isSaved: isSaved ?? this.isSaved,
        hasFailure: hasFailure ?? this.hasFailure,
        comboJobCat: comboJobCat ?? this.comboJobCat,
        comboJob: comboJob ?? this.comboJob,
        comboMedia: comboMedia ?? this.comboMedia,
        comboCustomer: comboCustomer ?? this.comboCustomer);
  }

  @override
  List<Object> get props =>
      [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
