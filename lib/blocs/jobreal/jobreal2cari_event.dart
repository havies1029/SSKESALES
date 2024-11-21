part of 'jobreal2cari_bloc.dart';

abstract class JobReal2CariEvents extends Equatable {
  const JobReal2CariEvents();

  @override
  List<Object> get props => [];
}

class FetchJobReal2CariEvent extends JobReal2CariEvents {
  final String custId;
  final String? jobreal1Id;
  final String? searchText;

  const FetchJobReal2CariEvent(
      {required this.custId, this.jobreal1Id, this.searchText});

  @override
  List<Object> get props => [custId];
}

class RefreshJobReal2CariEvent extends JobReal2CariEvents {
  final String custId;
  final String? jobreal1Id;
  final String? searchText;

  const RefreshJobReal2CariEvent(
      {required this.custId, this.jobreal1Id, this.searchText});

  @override
  List<Object> get props => [custId];
}

/*
class Update2StateJobReal2Event extends JobReal2CariEvents {
  final List<JobReal2CariModel> jobReal2List;

  const Update2StateJobReal2Event(
      {required this.jobReal2List});

  @override
  List<Object> get props => [jobReal2List];
}
*/

class Update2ApiJobReal2Event extends JobReal2CariEvents {
  final String jobreal1Id;
  //final List<JobReal2CariModel> jobReal2List;

  const Update2ApiJobReal2Event(
      {required this.jobreal1Id});
      //{required this.jobreal1Id, required this.jobReal2List});
  @override
  List<Object> get props => [jobreal1Id];
}

class RequestToUpdateJobReal2Event extends JobReal2CariEvents {}

class UpdateCheckboxJobReal2Event extends JobReal2CariEvents {
  final JobReal2CariModel jobReal2Item;
  final bool isChecked;

  const UpdateCheckboxJobReal2Event(
      {required this.jobReal2Item, required this.isChecked});

  @override
  List<Object> get props => [jobReal2Item, isChecked];
}


class ResetStateJobReal2CariEvent extends JobReal2CariEvents {}

class ResetStateJobReal2ForLoadDataPurposeCariEvent extends JobReal2CariEvents {}

class InitialSelectedSPPAJobReal2Event extends JobReal2CariEvents {
  final List<JobReal2CariModel> selectedSPPA;

  const InitialSelectedSPPAJobReal2Event(
      {required this.selectedSPPA});

  @override
  List<Object> get props => [selectedSPPA];
}

class ReplaceSelectedSppaJobReal2CariEvent extends JobReal2CariEvents {
  final List<JobReal2CariModel> selectedSPPA;

  const ReplaceSelectedSppaJobReal2CariEvent(
      {required this.selectedSPPA});

  @override
  List<Object> get props => [selectedSPPA];
}