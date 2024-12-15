import 'package:esalesapp/apis/combobox/combojobcatgroup_api.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';

class ComboJobcatgroupRepository {

	Future<List<ComboJobcatgroupModel>> getComboJobcatgroup() async {
		ComboJobcatgroupAPI api = ComboJobcatgroupAPI();
		return await api.getComboJobcatgroupAPI();
	}

  Future<List<ComboJobcatgroupModel>> getComboJobCatGroupByPersonId(String personId) async {
		ComboJobcatgroupAPI api = ComboJobcatgroupAPI();
		return await api.getComboJobcatgroupByPersonIdAPI(personId);
	}

  Future<ComboJobcatgroupModel> getComboJobcatgroupOtherAPI() async {
		ComboJobcatgroupAPI api = ComboJobcatgroupAPI();
		return await api.getComboJobcatgroupOtherAPI();
	}
}
