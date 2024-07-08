part of 'jobreal2grid_bloc.dart';

abstract class JobReal2ListEvents extends Equatable {
  const JobReal2ListEvents();

  @override
  List<Object> get props => [];
}

class FetchJobReal2ListEvent extends JobReal2ListEvents {
  final String jobreal1Id;

  const FetchJobReal2ListEvent({required this.jobreal1Id});

  @override
  List<Object> get props => [jobreal1Id];
}

class RefreshJobReal2ListEvent extends JobReal2ListEvents {
  final String jobreal1Id;

  const RefreshJobReal2ListEvent({required this.jobreal1Id});

  @override
  List<Object> get props => [jobreal1Id];
}

class DeleteAllJobReal2ListEvent extends JobReal2ListEvents {
  final String jobreal1Id;

  const DeleteAllJobReal2ListEvent({required this.jobreal1Id});

  @override
  List<Object> get props => [jobreal1Id];
}

class ResetStateJobReal2ListEvent extends JobReal2ListEvents {}

class ReloadGridJobReal2ListEvent extends JobReal2ListEvents {}

class GetPickedPoliciesJobReal2ListEvent extends JobReal2ListEvents {
  final List<JobReal2CariModel> pickedPolicies;
  
  const GetPickedPoliciesJobReal2ListEvent({required this.pickedPolicies});
  
  @override
  List<Object> get props => [pickedPolicies];
}
