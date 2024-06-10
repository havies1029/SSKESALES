part of 'jobreal3grid_bloc.dart';

abstract class JobReal3GridEvents extends Equatable {
	const JobReal3GridEvents();

	@override
	List<Object> get props => [];
}

class FetchJobReal3GridEvent extends JobReal3GridEvents {
  final String jobreal1Id;

  const FetchJobReal3GridEvent({required this.jobreal1Id});

  @override
  List<Object> get props => [jobreal1Id];
}

class RefreshJobReal3GridEvent extends JobReal3GridEvents {
  final String jobreal1Id;

  const RefreshJobReal3GridEvent({required this.jobreal1Id});

  @override
  List<Object> get props => [jobreal1Id];
}

class ResetStateJobReal3ListEvent extends JobReal3GridEvents {}

class ReloadGridJobReal3ListEvent extends JobReal3GridEvents {}

class GetPickedCobJobReal3ListEvent extends JobReal3GridEvents {
  final List<JobReal3CariModel> pickedCob;
  
  const GetPickedCobJobReal3ListEvent({required this.pickedCob});
  
  @override
  List<Object> get props => [pickedCob];
}

