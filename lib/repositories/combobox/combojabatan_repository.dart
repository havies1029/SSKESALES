import 'package:esalesapp/apis/combobox/combojabatan_api.dart';
import 'package:esalesapp/models/combobox/combojabatan_model.dart';

class ComboJabatanRepository {

	Future<List<ComboJabatanModel>> getComboJabatan(String filter) async {
		return await getComboJabatanAPI(filter);
	}
}
