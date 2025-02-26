import 'package:equatable/equatable.dart';

class PlanListModel extends Equatable {
  final String jobNama;
  final int planDurasi;
  final DateTime? planFinish;
  final DateTime? planStart;
  final String plan1Id;
  final int urutan;
  final int totalJob;
  final String? hasil;
  final String? jobreal1Id;
  final String? materi;
  final String? mediaNama;
  final String? picName;
  final DateTime? realTgl;
  final String? taskDesc;
  final String? rdPartyName;
  final bool? isConfirmed;
  final String? personalNama;
  final String? personalId;

  const PlanListModel(
      {this.jobNama = "",
      this.planDurasi = 0,
      this.planFinish,
      this.planStart,
      this.plan1Id = "",
      this.urutan = 0,
      this.totalJob = 0,
      this.hasil,
      this.jobreal1Id,
      this.materi,
      this.mediaNama,
      this.picName,
      this.realTgl,
      this.taskDesc,
      this.rdPartyName,
      this.isConfirmed,
      this.personalNama,
      this.personalId});

  factory PlanListModel.fromJson(Map<String, dynamic> data) {
    return PlanListModel(
      jobNama: data['jobNama'] ?? '',
      planDurasi: int.tryParse(data['planDurasi'].toString()) ?? 0,
      planFinish:
          DateTime.tryParse(data['planFinish'].toString()) ?? DateTime.now(),
      planStart:
          DateTime.tryParse(data['planStart'].toString()) ?? DateTime.now(),
      plan1Id: data['plan1Id'] ?? '',
      urutan: int.tryParse(data['urutan'].toString()) ?? 0,
      totalJob: int.tryParse(data['totalJob'].toString()) ?? 0,
      hasil: data['hasil'] ?? '',
      jobreal1Id: data['jobreal1Id'] ?? '',
      materi: data['materi'] ?? '',
      mediaNama: data['mediaNama'] ?? '',
      picName: data['picName'] ?? '',
      realTgl: DateTime.tryParse(data['realTgl'].toString()) ?? DateTime.now(),
      taskDesc: data['taskDesc'] ?? '',
      rdPartyName: data['rdPartyName'] ?? '',
      isConfirmed: data['isConfirmed'] ?? false,
      personalNama: data['personalNama'] ?? '',
      personalId: data['personalId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'jobNama': jobNama,
        'planDurasi': planDurasi.toString(),
        'planFinish': planFinish?.toIso8601String(),
        'planStart': planStart?.toIso8601String(),
        'plan1Id': plan1Id,
        'urutan': urutan.toString(),
        'totalJob': totalJob.toString(),
        'hasil': hasil,
        'jobreal1Id': jobreal1Id,
        'materi': materi,
        'mediaNama': mediaNama,
        'picName': picName,
        'realTgl': realTgl?.toIso8601String(),
        'taskDesc': taskDesc,
        'rdPartyName': rdPartyName,
        'isConfirmed': isConfirmed.toString(),
        'personalNama': personalNama,
        'personalId': personalId
      };

  @override
  List<Object> get props =>
      [jobNama, planDurasi, plan1Id, urutan, totalJob];
}
