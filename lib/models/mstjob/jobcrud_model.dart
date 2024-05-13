import 'package:esalesapp/models/combobox/combojobcat_model.dart';

class JobCrudModel {
	String jobNama;
	String mjobId;
	String? mjobcatId;
	ComboJobcatModel? comboJobcat;

	JobCrudModel({required this.jobNama, required this.mjobId, 
		this.mjobcatId, this.comboJobcat});

	factory JobCrudModel.fromJson(Map<String, dynamic> data) {
		ComboJobcatModel? comboJobcat;
		if (data['comboJobcat'] != null) {
			comboJobcat = ComboJobcatModel.fromJson(data['comboJobcat']);
		}

		return JobCrudModel(
			jobNama: data['jobNama']??'',
			mjobId: data['mjobId']??'',
			mjobcatId: data['mjobcatId']??'',
			comboJobcat: comboJobcat
		);

	}

	Map<String, dynamic> toJson() =>
		{'jobNama': jobNama,
		'mjobId': mjobId,
		'mjobcatId': mjobcatId,
		'comboJobcat': comboJobcat?.toJson()};

}
