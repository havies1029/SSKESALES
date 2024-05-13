import 'package:esalesapp/apis/combobox/combojob_api.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';

class ComboJobRepository {

	Future<List<ComboJobModel>> getComboJob(String mjobcatId) async {
		ComboJobAPI api = ComboJobAPI();
		return await api.getComboJobAPI(mjobcatId);
	}
}
