part of 'jobrealfoto_bloc.dart';

class JobRealFotoState extends Equatable {
  final bool isUploading;
  final bool isUploaded;
  final bool isDownloading;
  final bool isDownloaded;
  final bool isDeleting;
  final bool isDeleted;
  final bool hasFailure;
  //final Uint8List? fileFoto;
  final String fotoPath;

  const JobRealFotoState(
      {this.isUploading = false,
      this.isUploaded = false,
      this.isDownloading = false,
      this.isDownloaded = false,
      this.isDeleting = false,
      this.isDeleted = false,
      this.hasFailure = false,
      //this.fileFoto,
      this.fotoPath = ""});

  JobRealFotoState copyWith({
    bool? isUploading,
    bool? isUploaded,
    bool? isDownloading,
    bool? isDownloaded,
    bool? isDeleting,
    bool? isDeleted,
    bool? hasFailure,
    //Uint8List? fileFoto,
    String? fotoPath,
  }) {
    return JobRealFotoState(
        isUploading: isUploading ?? this.isUploading,
        isUploaded: isUploaded ?? this.isUploaded,
        isDownloading: isDownloading ?? this.isDownloading,
        isDownloaded: isDownloaded ?? this.isDownloaded,
        isDeleting: isDeleting ?? this.isDeleting,
        isDeleted: isDeleted ?? this.isDeleted,
        hasFailure: hasFailure ?? this.hasFailure,
        //fileFoto: fileFoto ?? this.fileFoto,
        fotoPath: fotoPath ?? this.fotoPath);
  }

  @override
  List<Object> get props =>
      [isUploading, isUploaded, isDownloaded, isDownloaded, hasFailure,
       isDeleting, isDeleted];
}
