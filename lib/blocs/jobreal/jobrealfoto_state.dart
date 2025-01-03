part of 'jobrealfoto_bloc.dart';

class JobRealFotoState extends Equatable {
  final bool isUploading;
  final bool isUploaded;
  final bool isDownloading;
  final bool isDownloaded;
  final bool isDeleting;
  final bool isDeleted;
  final bool hasFailure;
  final Uint8List? fotoBytes;
  final bool isPendingUpload;
  final String fotoPath;
  final String imageSource;
  final String errorMsg;
  final String fileName;

  const JobRealFotoState({
    this.isUploading = false,
    this.isUploaded = false,
    this.isDownloading = false,
    this.isDownloaded = false,
    this.isDeleting = false,
    this.isDeleted = false,
    this.hasFailure = false,
    this.isPendingUpload = false,
    this.fotoBytes,
    this.fotoPath = "",
    this.imageSource = "",
    this.errorMsg = "",
    this.fileName = "",
  });

  const JobRealFotoState.reset()
      : this(fotoPath: "", fotoBytes: null, fileName: "", imageSource: "");

  JobRealFotoState copyWith({
    bool? isUploading,
    bool? isUploaded,
    bool? isDownloading,
    bool? isDownloaded,
    bool? isDeleting,
    bool? isDeleted,
    bool? hasFailure,
    bool? isPendingUpload,
    Uint8List? fotoBytes,
    String? fotoPath,
    String? imageSource,
    String? errorMsg,
    String? fileName,
  }) {
    return JobRealFotoState(
        isUploading: isUploading ?? this.isUploading,
        isUploaded: isUploaded ?? this.isUploaded,
        isDownloading: isDownloading ?? this.isDownloading,
        isDownloaded: isDownloaded ?? this.isDownloaded,
        isDeleting: isDeleting ?? this.isDeleting,
        isDeleted: isDeleted ?? this.isDeleted,
        hasFailure: hasFailure ?? this.hasFailure,
        isPendingUpload: isPendingUpload ?? this.isPendingUpload,
        fotoBytes: fotoBytes ?? this.fotoBytes,
        fotoPath: fotoPath ?? this.fotoPath,
        imageSource: imageSource ?? this.imageSource,
        errorMsg: errorMsg ?? this.errorMsg,
        fileName: fileName ?? this.fileName
      );
  }

  @override
  List<Object> get props => [
        isUploading,
        isUploaded,
        isDownloaded,
        isDownloaded,
        hasFailure,
        isDeleting,
        isDeleted,
        isPendingUpload,
        imageSource,
        errorMsg,
        fileName,
      ];
}
