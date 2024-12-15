import 'package:equatable/equatable.dart';

class BriefinglistModel extends Equatable {
  final bool confirmed;
  final String jobreal1Id;
  final String jobId;
  final String jobNama;
  final String jobCatId;
  final int urutan;

  const BriefinglistModel(
      {this.confirmed = false,
      this.jobreal1Id = "",
      this.jobId = "",
      this.jobNama = "",
      this.jobCatId = "",
      this.urutan = 0});

  factory BriefinglistModel.fromJson(Map<String, dynamic> data) {

    return BriefinglistModel(
        confirmed: data['confirmed'] ?? false,
        jobreal1Id: data['jobreal1Id'] ?? '',
        jobId: data['jobId'] ?? '',
        jobNama: data['jobNama'] ?? '',
        jobCatId: data['jobCatId'] ?? '',
        urutan: int.tryParse(data['urutan'].toString()) ?? 0);
  }

  Map<String, dynamic> toJson() => {
        'confirmed': confirmed,
        'jobreal1Id': jobreal1Id,
        'jobId': jobId,
        'jobNama': jobNama,
        'jobCatId': jobCatId,
        'urutan': urutan.toString()
      };

  	@override
	List<Object> get props => [confirmed, jobreal1Id, jobId, jobNama, jobCatId, urutan];
}
