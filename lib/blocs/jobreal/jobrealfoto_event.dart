part of 'jobrealfoto_bloc.dart';

abstract class JobRealFotoEvents extends Equatable {
  const JobRealFotoEvents();

  @override
  List<Object> get props => [];
}

class UploadFotoJobRealEvent extends JobRealFotoEvents {
  final String jobReal1Id;
  final String filePath;
  final String imageSource;
  const UploadFotoJobRealEvent(
      {required this.jobReal1Id,
      required this.filePath,
      required this.imageSource});

  @override
  List<Object> get props => [jobReal1Id, filePath, imageSource];
}

class UploadFotoBytesJobRealEvent extends JobRealFotoEvents {
  final String jobReal1Id;
  final String fileName;
  final Uint8List bytes;
  final String imageSource;
  const UploadFotoBytesJobRealEvent(
      {required this.jobReal1Id,
      required this.fileName,
      required this.bytes,
      required this.imageSource});

  @override
  List<Object> get props => [jobReal1Id, fileName, bytes, imageSource];
}

class Save2StateFotoLocalPathJobRealEvent extends JobRealFotoEvents {
  final String filePath;
  final String imageSource;
  const Save2StateFotoLocalPathJobRealEvent(
      {required this.filePath, required this.imageSource});

  @override
  List<Object> get props => [filePath, imageSource];
}

class Save2StateFotoBinaryJobRealEvent extends JobRealFotoEvents {
  final Uint8List fotoBytes;
  final String imageSource;
  final String fileName;
  const Save2StateFotoBinaryJobRealEvent(
      {required this.fotoBytes, required this.imageSource, required this.fileName});

  @override
  List<Object> get props => [fotoBytes, imageSource, fileName];
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

class SetErrorJobRealFotoEvent extends JobRealFotoEvents {
  final String errorMsg;
  const SetErrorJobRealFotoEvent({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
