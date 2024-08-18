import 'package:equatable/equatable.dart';

class ComboJobcatgroupModel extends Equatable {
  final String mjobcatgroupId;
  final String groupNama;
  final int urutan;
  final bool hasIndex;

  const ComboJobcatgroupModel(
      {this.mjobcatgroupId = '', this.groupNama = '', this.urutan = 0, 
       this.hasIndex = false});

  factory ComboJobcatgroupModel.fromJson(Map<String, dynamic> data) =>
      ComboJobcatgroupModel(
          mjobcatgroupId: data['mjobcatgroupId'],
          groupNama: data['groupNama'],
          urutan: data['urutan'],
          hasIndex: data['hasIndex']??false);

  Map<String, dynamic> toJson() => {
        'mjobcatgroupId': mjobcatgroupId,
        'groupNama': groupNama,
        'urutan': int.parse(urutan.toString()),
        'hasIndex': hasIndex.toString()
      };

  @override
  List<Object> get props => [mjobcatgroupId, groupNama, urutan, hasIndex];
}
