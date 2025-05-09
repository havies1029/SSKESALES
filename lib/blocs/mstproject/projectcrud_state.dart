part of 'projectcrud_bloc.dart';

class ProjectCrudState extends Equatable {
  final ProjectCrudModel? record;
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
  final ComboCustomerModel? comboCustomer;
  final ComboCobModel? comboCob;
  final ComboMMstJobcatModel? comboMstJobCat;
  const ProjectCrudState({
    this.record,
    this.isLoading = false,
    this.isLoaded = false,
    this.isSaving = false,
    this.isSaved = false,
    this.hasFailure = false,
    this.comboCustomer,
    this.comboCob,
    this.comboMstJobCat,
  });

  ProjectCrudState copyWith({
    ProjectCrudModel? record,
    bool? isLoading,
    bool? isLoaded,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,
    ComboCustomerModel? comboCustomer,
    ComboCobModel? comboCob,
    ComboMMstJobcatModel? comboMstJobCat,
  }) {
    debugPrint("copyWith -> comboCob : ${jsonEncode(comboCob?.toJson())}");

    return ProjectCrudState(
      record: record ?? this.record,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      hasFailure: hasFailure ?? this.hasFailure,
      comboCustomer: comboCustomer ?? this.comboCustomer,
      comboCob: comboCob ?? this.comboCob,
      comboMstJobCat: comboMstJobCat ?? this.comboMstJobCat,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
