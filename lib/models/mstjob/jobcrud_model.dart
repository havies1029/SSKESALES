import 'package:esalesapp/models/combobox/combocustcat_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';

class JobCrudModel {
	String jobNama;
	String mjobId;
	String? mjobcatId;
	ComboJobcatModel? comboJobcat;
  ComboCustCatModel? comboCustCat;
  double urutRenew; 

	JobCrudModel({required this.jobNama, required this.mjobId, 
		this.mjobcatId, this.comboJobcat, this.comboCustCat, required this.urutRenew
     });

	factory JobCrudModel.fromJson(Map<String, dynamic> data) {
		ComboJobcatModel? comboJobcat;
		if (data['comboJobcat'] != null) {
			comboJobcat = ComboJobcatModel.fromJson(data['comboJobcat']);
		}

    ComboCustCatModel? comboCustCat;
    if (data['comboCustCat'] != null) {
      comboCustCat = ComboCustCatModel.fromJson(data['comboCustCat']);
    }

		return JobCrudModel(
			jobNama: data['jobNama']??'',
			mjobId: data['mjobId']??'',
			mjobcatId: data['mjobcatId']??'',
			comboJobcat: comboJobcat,      
      comboCustCat: comboCustCat,
      urutRenew: data['urutRenew'] ?? '',
		);

	}

	Map<String, dynamic> toJson() =>
		{'jobNama': jobNama,
		'mjobId': mjobId,
		'mjobcatId': mjobcatId,
		'comboJobcat': comboJobcat?.toJson(),
    'comboCustCat': comboCustCat?.toJson(),
    'urutRenew': urutRenew,
  };

}
