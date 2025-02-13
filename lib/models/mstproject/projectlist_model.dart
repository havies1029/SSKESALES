class ProjectListModel {
  DateTime dateline;
  String mprojectId;
  String mrekanId;
  String projectNama;
  String rekanNama;

  ProjectListModel(
      {required this.dateline,
      required this.mprojectId,
      required this.mrekanId,
      required this.projectNama,
      required this.rekanNama});

  factory ProjectListModel.fromJson(Map<String, dynamic> data) {
    return ProjectListModel(
        dateline:
            DateTime.tryParse(data['dateline'].toString()) ?? DateTime.now(),
        mprojectId: data['mprojectId'] ?? '',
        mrekanId: data['mrekanId'] ?? '',
        projectNama: data['projectNama'] ?? '',
        rekanNama: data['rekanNama'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'dateline': dateline.toIso8601String(),
        'mprojectId': mprojectId,
        'mrekanId': mrekanId,
        'projectNama': projectNama,
        'rekanNama': rekanNama
      };
}
