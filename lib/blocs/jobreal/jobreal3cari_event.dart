part of 'jobreal3cari_bloc.dart';

abstract class JobReal3CariEvents extends Equatable {
	const JobReal3CariEvents();

	@override
	List<Object> get props => [];
}

class FetchJobReal3CariEvent extends JobReal3CariEvents {
  final String jobreal1Id;
	final String searchText;

	const FetchJobReal3CariEvent({required this.jobreal1Id, required this.searchText});

	@override
	List<Object> get props => [jobreal1Id, searchText];
}

class RefreshJobReal3CariEvent extends JobReal3CariEvents {
  final String jobreal1Id;
  final int hal;
	final String searchText;

	const RefreshJobReal3CariEvent({required this.jobreal1Id, required this.hal, required this.searchText});

	@override
	List<Object> get props => [jobreal1Id, hal, searchText];
}

class UpdateCheckboxJobReal3Event extends JobReal3CariEvents {
  final JobReal3CariModel jobReal3Item;
  final bool isChecked;

  const UpdateCheckboxJobReal3Event(
      {required this.jobReal3Item, required this.isChecked});

  @override
  List<Object> get props => [jobReal3Item, isChecked];
}

class RequestToUpdateJobReal3Event extends JobReal3CariEvents {}

class Update2ApiJobReal3Event extends JobReal3CariEvents {
  final String jobreal1Id;

  const Update2ApiJobReal3Event({required this.jobreal1Id});
  @override
  List<Object> get props => [jobreal1Id];
}

class ResetStateJobReal3CariEvent extends JobReal3CariEvents {}

class ResetStateJobReal3ForLoadDataPurposeCariEvent extends JobReal3CariEvents {}

class InitialSelectedCOBJobReal3Event extends JobReal3CariEvents {
  final List<JobReal3CariModel> selectedCOB;

  const InitialSelectedCOBJobReal3Event(
      {required this.selectedCOB});

  @override
  List<Object> get props => [selectedCOB];
}