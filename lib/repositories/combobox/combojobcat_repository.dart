import 'package:esalesapp/apis/combobox/combojobcat_api.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';

class ComboJobcatRepository {

	Future<List<ComboJobcatModel>> getComboJobcat() async {
		ComboJobcatAPI api = ComboJobcatAPI();
		return await api.getComboJobcatAPI();
	}
}
