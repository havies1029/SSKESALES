import 'package:equatable/equatable.dart';

class ComboJobcatgroupModel extends Equatable {
  final String mjobcatgroupId;
  final String groupNama;
  final int urutan;
  final bool hasIndex;
  final int totalJob;

  const ComboJobcatgroupModel(
      {this.mjobcatgroupId = '', this.groupNama = '', this.urutan = 0, 
       this.hasIndex = false, this.totalJob = 0});

  factory ComboJobcatgroupModel.fromJson(Map<String, dynamic> data) =>
      ComboJobcatgroupModel(
          mjobcatgroupId: data['mjobcatgroupId'],
          groupNama: data['groupNama'],
          urutan: data['urutan'],
          totalJob: data['totalJob'],
          hasIndex: data['hasIndex']??false);

  Map<String, dynamic> toJson() => {
        'mjobcatgroupId': mjobcatgroupId,
        'groupNama': groupNama,
        'urutan': int.parse(urutan.toString()),
        'totalJob': int.parse(totalJob.toString()),
        'hasIndex': hasIndex.toString()
      };

  @override
  List<Object> get props => [mjobcatgroupId, groupNama, urutan, hasIndex, totalJob];
}
