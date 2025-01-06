part of 'jobrealcrud_bloc.dart';

abstract class JobRealCrudEvents extends Equatable {
  const JobRealCrudEvents();

  @override
  List<Object> get props => [];
}

class JobRealCrudResetStateEvent extends JobRealCrudEvents {}

class JobRealCrudPreOpenEvent extends JobRealCrudEvents {
  final String viewmode;
  const JobRealCrudPreOpenEvent({required this.viewmode});

  @override
  List<Object> get props => [viewmode];
}

class JobRealCrudTambahEvent extends JobRealCrudEvents {
  final JobRealCrudModel record;
  final List<JobReal2CariModel> selectedSppa;

  const JobRealCrudTambahEvent(
      {required this.record, required this.selectedSppa});

  @override
  List<Object> get props => [record, selectedSppa];
}

class JobRealCrudUbahEvent extends JobRealCrudEvents {
  final JobRealCrudModel record;
  const JobRealCrudUbahEvent({required this.record});

  @override
  List<Object> get props => [record];
}

class JobRealCrudHapusEvent extends JobRealCrudEvents {
  final String recordId;
  const JobRealCrudHapusEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class JobRealOtorisasiEvent extends JobRealCrudEvents {
  final String recordId;
  const JobRealOtorisasiEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class JobRealCrudLihatEvent extends JobRealCrudEvents {
  final String recordId;
  const JobRealCrudLihatEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class ComboJobcatChangedEvent extends JobRealCrudEvents {
  final ComboJobcatModel comboJobcat;
  const ComboJobcatChangedEvent({required this.comboJobcat});

  @override
  List<Object> get props => [comboJobcat];
}

class ComboJobChangedEvent extends JobRealCrudEvents {
  final ComboJobModel comboJob;
  const ComboJobChangedEvent({required this.comboJob});

  @override
  List<Object> get props => [comboJob];
}

class ComboCustomerJobRealCrudChangedEvent extends JobRealCrudEvents {
  final ComboCustomerModel comboCustomer;
  const ComboCustomerJobRealCrudChangedEvent({required this.comboCustomer});

  @override
  List<Object> get props => [comboCustomer];
}

class ComboInsurerJobRealCrudChangedEvent extends JobRealCrudEvents {
  final ComboInsurerModel comboInsurer;
  const ComboInsurerJobRealCrudChangedEvent({required this.comboInsurer});

  @override
  List<Object> get props => [comboInsurer];
}

class ComboMediaChangedEvent extends JobRealCrudEvents {
  final ComboMediaModel comboMedia;
  const ComboMediaChangedEvent({required this.comboMedia});

  @override
  List<Object> get props => [comboMedia];
}

class Request2RefreshJobRealCrudEvent extends JobRealCrudEvents {}

class UndoComboCustomerJobRealCrudChangedEvent extends JobRealCrudEvents {
  final ComboCustomerModel? comboCustomer;
  const UndoComboCustomerJobRealCrudChangedEvent({this.comboCustomer});
}

class FinishedUndoComboCustomerJobRealCrudChangedEvent
    extends JobRealCrudEvents {}

class GetInitValueNewBriefingHarianModeEvent extends JobRealCrudEvents {
  final String jobId;
  final String jobCatId;
  const GetInitValueNewBriefingHarianModeEvent(
      {required this.jobId, required this.jobCatId});

  @override
  List<Object> get props => [jobId, jobCatId];
}

class GetInitValueNewSOAClientModeEvent extends JobRealCrudEvents {
  final String dn1Id;  
  const GetInitValueNewSOAClientModeEvent({required this.dn1Id});

  @override
  List<Object> get props => [dn1Id];
}

class SetFotoUploadedEvent extends JobRealCrudEvents{}