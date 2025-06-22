part of 'jobrealcrud_bloc.dart';

class JobRealCrudState extends Equatable {
  final JobRealCrudModel? record;
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
  final String viewMode;
  final ComboJobcatModel? comboJobCat;
  final ComboJobModel? comboJob;
  final ComboMediaModel? comboMedia;
  final ComboCustomerModel? comboCustomer;
  final ComboInsurerModel? comboInsurer;
  final ComboMProjectModel? comboProject;
  final ComboTodoListModel? comboTodoList;
  final bool requireComboInsurer;
  final bool forceChangeComboCustomer;
  const JobRealCrudState(
      {this.record,
      this.isLoading = false,
      this.isLoaded = false,
      this.isSaving = false,
      this.isSaved = false,
      this.hasFailure = false,
      this.viewMode = "",
      this.comboJobCat,
      this.comboJob,
      this.comboMedia,
      this.comboCustomer,
      this.comboInsurer,
      this.comboProject,
      this.comboTodoList,
      this.requireComboInsurer = false,
      this.forceChangeComboCustomer = false});

  JobRealCrudState copyWith({
    JobRealCrudModel? record,
    bool? isLoading,
    bool? isLoaded,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,
    String? viewMode,
    ComboJobcatModel? comboJobCat,
    ComboJobModel? comboJob,
    ComboMediaModel? comboMedia,
    ComboCustomerModel? comboCustomer,
    ComboInsurerModel? comboInsurer,
    ComboMProjectModel? comboProject,
    ComboTodoListModel? comboTodoList,
    bool? requireComboInsurer,
    bool? forceChangeComboCustomer,
  }) {
    return JobRealCrudState(
        record: record ?? this.record,
        isLoading: isLoading ?? this.isLoading,
        isLoaded: isLoaded ?? this.isLoaded,
        isSaving: isSaving ?? this.isSaving,
        isSaved: isSaved ?? this.isSaved,
        hasFailure: hasFailure ?? this.hasFailure,
        viewMode: viewMode ?? this.viewMode,
        comboJobCat: comboJobCat ?? this.comboJobCat,
        comboJob: comboJob ?? this.comboJob,
        comboMedia: comboMedia ?? this.comboMedia,
        comboCustomer: comboCustomer ?? this.comboCustomer,
        comboInsurer: comboInsurer ?? this.comboInsurer,
        comboProject: comboProject ?? this.comboProject,
        comboTodoList: comboTodoList ?? this.comboTodoList,
        requireComboInsurer: requireComboInsurer ?? this.requireComboInsurer,
        forceChangeComboCustomer:
            forceChangeComboCustomer ?? this.forceChangeComboCustomer);
  }

  @override
  List<Object> get props => [
        isLoading,
        isLoaded,
        isSaving,
        isSaved,
        hasFailure,
        viewMode,
        requireComboInsurer,
        forceChangeComboCustomer,
      ];
}
