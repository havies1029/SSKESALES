part of 'jobreal2cari_bloc.dart';

class JobReal2CariState extends Equatable {
  final ListStatus status;
  final List<JobReal2CariModel> items;
  final bool hasReachedMax;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
	final int hal;
  final bool requestToUpdate;
  final List<JobReal2CariModel> selectedItems;

  const JobReal2CariState(
      {this.status = ListStatus.initial,
      this.items = const <JobReal2CariModel>[],
      this.hasReachedMax = false,
      this.isSaving = false,
      this.isSaved = false,
      this.hasFailure = false,
		  this.hal = 0,
      this.requestToUpdate = false,
      this.selectedItems = const <JobReal2CariModel>[]});

  const JobReal2CariState.success(List<JobReal2CariModel> items)
      : this(status: ListStatus.success, items: items);

  const JobReal2CariState.failure() : this(status: ListStatus.failure);

  JobReal2CariState copyWith({
    List<JobReal2CariModel>? items,
    bool? hasReachedMax,
    ListStatus? status,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,
		int? hal,
    bool? requestToUpdate,
    List<JobReal2CariModel>? selectedItems,
  }) {
    return JobReal2CariState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      hasFailure: hasFailure ?? this.hasFailure,
			hal: hal ?? this.hal,
      requestToUpdate: requestToUpdate ?? this.requestToUpdate,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }

  @override
  List<Object> get props => [
        status,
        items,
        hasReachedMax,
        isSaving,
        isSaved,
        hasFailure,
        requestToUpdate,
        selectedItems,
        hal
      ];
}
