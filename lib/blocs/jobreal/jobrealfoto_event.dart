part of 'jobrealfoto_bloc.dart';

abstract class JobRealFotoEvents extends Equatable {
  const JobRealFotoEvents();

  @override
  List<Object> get props => [];
}

class UploadFotoJobRealEvent extends JobRealFotoEvents {
  final String jobReal1Id;
  final String filePath;
  const UploadFotoJobRealEvent({required this.jobReal1Id, required this.filePath});

  @override
  List<Object> get props => [jobReal1Id, filePath];
}


class Save2StateFotoJobRealEvent extends JobRealFotoEvents {
  final String filePath;
  const Save2StateFotoJobRealEvent({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class DownloadFotoJobRealEvent extends JobRealFotoEvents {
  final String jobReal1Id;
  const DownloadFotoJobRealEvent({required this.jobReal1Id});

  @override
  List<Object> get props => [jobReal1Id];
}

class HapusFotoAPIJobRealEvent extends JobRealFotoEvents {
  final String jobReal1Id;
  const HapusFotoAPIJobRealEvent({required this.jobReal1Id});

  @override
  List<Object> get props => [jobReal1Id];
}


class HapusFotoStateJobRealFotoEvent extends JobRealFotoEvents {}

class ResetStateJobRealFotoEvent extends JobRealFotoEvents {}