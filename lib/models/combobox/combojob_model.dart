import 'package:equatable/equatable.dart';

class ComboJobModel extends Equatable {
  final String mjobId;
  final String jobNama;
  final bool isReqDetail;

  const ComboJobModel({this.mjobId = '', this.jobNama = '', this.isReqDetail = true});

  factory ComboJobModel.fromJson(Map<String, dynamic> data) => ComboJobModel(
        mjobId: data['mjobId'],
        jobNama: data['jobNama'],
        isReqDetail: data['isReqDetail'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        'mjobId': mjobId,
        'jobNama': jobNama,        
        'isReqDetail': isReqDetail.toString(),
      };

  @override
  List<Object> get props => [mjobId, jobNama, isReqDetail];
}
