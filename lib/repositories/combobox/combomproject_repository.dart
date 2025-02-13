import 'package:esalesapp/apis/combobox/combomproject_api.dart';
import 'package:esalesapp/models/combobox/combomproject_model.dart';

class ComboMProjectRepository {

	Future<List<ComboMProjectModel>> getComboMProject(String rekanId) async {
		ComboMProjectAPI api = ComboMProjectAPI();
		return await api.getComboMProjectAPI(rekanId);
	}
}
