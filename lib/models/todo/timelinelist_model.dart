
class TimelineListModel {
	String aktivitas;
	DateTime jamAkhir;
	DateTime jamMulai;
	String mjobId;
	String mjobcatId;
	DateTime tglTimeline;
	String timeline1Id;
	String catName;
	String jobNama;

	TimelineListModel({required this.aktivitas, required this.jamAkhir, 
		required this.jamMulai, required this.mjobId, 
		required this.mjobcatId, required this.tglTimeline, 
		required this.timeline1Id, required this.catName, 
		required this.jobNama});

	factory TimelineListModel.fromJson(Map<String, dynamic> data) {
		return TimelineListModel(
			aktivitas: data['aktivitas']??'',
			jamAkhir: DateTime.tryParse(data['jamAkhir'].toString())??DateTime.now(),
			jamMulai: DateTime.tryParse(data['jamMulai'].toString())??DateTime.now(),
			mjobId: data['mjobId']??'',
			mjobcatId: data['mjobcatId']??'',
			tglTimeline: DateTime.tryParse(data['tglTimeline'].toString())??DateTime.now(),
			timeline1Id: data['timeline1Id']??'',
			catName: data['catName']??'',
			jobNama: data['jobNama']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'aktivitas': aktivitas,
		'jamAkhir': jamAkhir.toIso8601String(),
		'jamMulai': jamMulai.toIso8601String(),
		'mjobId': mjobId,
		'mjobcatId': mjobcatId,
		'tglTimeline': tglTimeline.toIso8601String(),
		'timeline1Id': timeline1Id,
		'catName': catName,
		'jobNama': jobNama};

}
