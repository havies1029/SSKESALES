import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';

class TodoTimelineCrudModel {
	String? aktivitas;
	DateTime? jamAkhir;
	DateTime? jamMulai;
	DateTime? tglTimeline;
	String? timeline1Id;
	String? mjobcatgroupId;
	ComboJobcatgroupModel? comboJobcatgroup;

	TodoTimelineCrudModel({this.aktivitas, this.jamAkhir, 
		this.jamMulai, this.tglTimeline, 
		this.timeline1Id, this.mjobcatgroupId, this.comboJobcatgroup});

	factory TodoTimelineCrudModel.fromJson(Map<String, dynamic> data) {
		ComboJobcatgroupModel? comboJobcatgroup;
		if (data['comboJobcatgroup'] != null) {
			comboJobcatgroup = ComboJobcatgroupModel.fromJson(data['comboJobcatgroup']);
		}

		return TodoTimelineCrudModel(
			aktivitas: data['aktivitas']??'',
			jamAkhir: DateTime.tryParse(data['jamAkhir'].toString())??DateTime.now(),
			jamMulai: DateTime.tryParse(data['jamMulai'].toString())??DateTime.now(),
			tglTimeline: DateTime.tryParse(data['tglTimeline'].toString())??DateTime.now(),
			timeline1Id: data['timeline1Id']??'',
			mjobcatgroupId: data['mjobcatgroupId']??'',
			comboJobcatgroup: comboJobcatgroup
		);

	}

	Map<String, dynamic> toJson() =>
		{'aktivitas': aktivitas,
		'jamAkhir': jamAkhir?.toIso8601String(),
		'jamMulai': jamMulai?.toIso8601String(),
		'tglTimeline': tglTimeline?.toIso8601String(),
		'timeline1Id': timeline1Id,
		'mjobcatgroupId': mjobcatgroupId,
		'comboJobcatgroup': comboJobcatgroup?.toJson()};

}
