class SppaCariModel {
  DateTime periodeAkhir;
  DateTime periodeAwal;
  String sppaNo;
  String lastTask;
  int jobIndex;
  int totalJob;
  int jobCount;
  String cob;
  String polisId;

  SppaCariModel(
      {required this.periodeAkhir,
      required this.periodeAwal,
      required this.sppaNo,
      required this.lastTask,
      required this.jobIndex,
      required this.totalJob,
      required this.jobCount,
      required this.cob,
      required this.polisId});

  factory SppaCariModel.fromJson(Map<String, dynamic> data) {
    return SppaCariModel(
        periodeAkhir: DateTime.tryParse(data['periodeAkhir'].toString()) ??
            DateTime.now(),
        periodeAwal:
            DateTime.tryParse(data['periodeAwal'].toString()) ?? DateTime.now(),
        sppaNo: data['sppaNo'] ?? '',
        lastTask: data['lastTask'] ?? '',
        jobIndex: data['jobIndex'] ?? 0,
        totalJob: data['totalJob'] ?? 0,
        jobCount: data['jobCount'] ?? 0,
        cob: data['cob'] ?? '',
        polisId: data['polisId'] ?? '',);
  }

  Map<String, dynamic> toJson() => {
        'periodeAkhir': periodeAkhir.toIso8601String(),
        'periodeAwal': periodeAwal.toIso8601String(),
        'sppaNo': sppaNo,
        'lastTask': lastTask,
        'jobIndex': jobIndex,
        'totalJob': totalJob,
        'jobCount': jobCount,
        'cob': cob,
        'polisId': polisId
      };
}
