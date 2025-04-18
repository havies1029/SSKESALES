import 'package:esalesapp/apis/combobox/combocob_api.dart';
import 'package:esalesapp/models/combobox/combocob_model.dart';

class ComboCobRepository {

	Future<List<ComboCobModel>> getComboCob(String filter) async {
		ComboCobAPI api = ComboCobAPI();
		return await api.getComboCobAPI(filter);
	}
}
