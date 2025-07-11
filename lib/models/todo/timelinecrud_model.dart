
class TimelineCrudModel {
	String aktivitas;
	DateTime jamAkhir;
	DateTime jamMulai;
	DateTime tglTimeline;
	String timeline1Id;

	TimelineCrudModel({required this.aktivitas, required this.jamAkhir, 
		required this.jamMulai, required this.tglTimeline, 
		required this.timeline1Id});

	factory TimelineCrudModel.fromJson(Map<String, dynamic> data) {
		return TimelineCrudModel(
			aktivitas: data['aktivitas']??'',
			jamAkhir: DateTime.tryParse(data['jamAkhir'].toString())??DateTime.now(),
			jamMulai: DateTime.tryParse(data['jamMulai'].toString())??DateTime.now(),
			tglTimeline: DateTime.tryParse(data['tglTimeline'].toString())??DateTime.now(),
			timeline1Id: data['timeline1Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'aktivitas': aktivitas,
		'jamAkhir': jamAkhir.toIso8601String(),
		'jamMulai': jamMulai.toIso8601String(),
		'tglTimeline': tglTimeline.toIso8601String(),
		'timeline1Id': timeline1Id};

}
