
class TodoTimelineListModel {
	String aktivitas;
	DateTime jamAkhir;
	DateTime jamMulai;
	String mjobcatgroupId;
	DateTime tglTimeline;
	String timeline1Id;
	String groupNama;

	TodoTimelineListModel({required this.aktivitas, required this.jamAkhir, 
		required this.jamMulai, required this.mjobcatgroupId, 
		required this.tglTimeline, required this.timeline1Id, 
		required this.groupNama});

	factory TodoTimelineListModel.fromJson(Map<String, dynamic> data) {
		return TodoTimelineListModel(
			aktivitas: data['aktivitas']??'',
			jamAkhir: DateTime.tryParse(data['jamAkhir'].toString())??DateTime.now(),
			jamMulai: DateTime.tryParse(data['jamMulai'].toString())??DateTime.now(),
			mjobcatgroupId: data['mjobcatgroupId']??'',
			tglTimeline: DateTime.tryParse(data['tglTimeline'].toString())??DateTime.now(),
			timeline1Id: data['timeline1Id']??'',
			groupNama: data['groupNama']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'aktivitas': aktivitas,
		'jamAkhir': jamAkhir.toIso8601String(),
		'jamMulai': jamMulai.toIso8601String(),
		'mjobcatgroupId': mjobcatgroupId,
		'tglTimeline': tglTimeline.toIso8601String(),
		'timeline1Id': timeline1Id,
		'groupNama': groupNama};

}
