import 'package:equatable/equatable.dart';

class ComboJobModel extends Equatable {
  final String mjobId;
  final String jobNama;
  final bool isReqDetail;
  final int urutan;

  const ComboJobModel(
      {this.mjobId = '', this.jobNama = '', 
    this.isReqDetail = true, this.urutan = 0});

  factory ComboJobModel.fromJson(Map<String, dynamic> data) => ComboJobModel(
        mjobId: data['mjobId'],
        jobNama: data['jobNama'],
        isReqDetail: data['isReqDetail'] ?? true,
        urutan: data['urutan'] ?? 0
      );

  Map<String, dynamic> toJson() => {
        'mjobId': mjobId,
        'jobNama': jobNama,        
        'isReqDetail': isReqDetail.toString(),
        'urutan': urutan.toString()
      };

  @override
  List<Object> get props => [mjobId, jobNama, isReqDetail, urutan];
}
