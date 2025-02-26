import 'package:esalesapp/models/combobox/combomproject_model.dart';

class PlanCrudModel {
	String jobNama;
	int planDurasi;
	DateTime planFinish;
	DateTime planStart;
	String plan1Id;
	int urutan;
	String? mprojectId;
	ComboMProjectModel? comboMProject;

	PlanCrudModel({required this.jobNama, required this.planDurasi, 
		required this.planFinish, required this.planStart, 
		required this.plan1Id, required this.urutan, 
		this.mprojectId, this.comboMProject});

	factory PlanCrudModel.fromJson(Map<String, dynamic> data) {
		ComboMProjectModel? comboMProject;
		if (data['comboMProject'] != null) {
			comboMProject = ComboMProjectModel.fromJson(data['comboMProject']);
		}

		return PlanCrudModel(
			jobNama: data['jobNama']??'',
			planDurasi: int.tryParse(data['planDurasi'].toString())??0,
			planFinish: DateTime.tryParse(data['planFinish'].toString())??DateTime.now(),
			planStart: DateTime.tryParse(data['planStart'].toString())??DateTime.now(),
			plan1Id: data['plan1Id']??'',
			urutan: int.tryParse(data['urutan'].toString())??0,
			mprojectId: data['mprojectId']??'',
			comboMProject: comboMProject
		);

	}

	Map<String, dynamic> toJson() =>
		{'jobNama': jobNama,
		'planDurasi': planDurasi.toString(),
		'planFinish': planFinish.toIso8601String(),
		'planStart': planStart.toIso8601String(),
		'plan1Id': plan1Id,
		'urutan': urutan.toString(),
		'mprojectId': mprojectId,
		'comboMProject': comboMProject?.toJson()};

}
