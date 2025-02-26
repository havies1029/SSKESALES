class ProjectListModel {
  DateTime dateline;
  String mprojectId;
  String mrekanId;
  String projectNama;
  String rekanNama;
  String cobNama;
  String catName;
  DateTime? startedDate;

  ProjectListModel(
      {required this.dateline,
      required this.mprojectId,
      required this.mrekanId,
      required this.projectNama,
      required this.rekanNama,
      required this.cobNama,
      required this.catName,
      this.startedDate});

  factory ProjectListModel.fromJson(Map<String, dynamic> data) {
    
    DateTime? startedDate = DateTime.tryParse(data['startedDate']);
    if (startedDate != null) {
      if (startedDate == DateTime.parse("0001-01-01T00:00:00")) {
        startedDate = null;
      }
    }

    return ProjectListModel(
        dateline:
            DateTime.tryParse(data['dateline'].toString()) ?? DateTime.now(),
        mprojectId: data['mprojectId'] ?? '',
        mrekanId: data['mrekanId'] ?? '',
        projectNama: data['projectNama'] ?? '',
        rekanNama: data['rekanNama'] ?? '',
        cobNama: data['cobNama'] ?? '',
        catName: data['catName'] ?? '',
        startedDate: startedDate);
  }

  Map<String, dynamic> toJson() => {
        'dateline': dateline.toIso8601String(),
        'mprojectId': mprojectId,
        'mrekanId': mrekanId,
        'projectNama': projectNama,
        'rekanNama': rekanNama,
        'cobNama': cobNama,
        'catName': catName,
        'startedDate': startedDate?.toIso8601String()
      };
}
