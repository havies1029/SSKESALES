import 'package:esalesapp/apis/combobox/combopolis_api.dart';
import 'package:esalesapp/models/combobox/combopolis_model.dart';

class ComboPolisRepository {

	Future<List<ComboPolisModel>> getComboPolis(String filter) async {
		ComboPolisAPI api = ComboPolisAPI();
		return await api.getComboPolisAPI(filter);
	}
}
