import 'package:esalesapp/apis/combobox/combocustcat_api.dart';
import 'package:esalesapp/models/combobox/combocustcat_model.dart';

class ComboCustCatRepository {

	Future<List<ComboCustCatModel>> getComboCustCat() async {
		ComboCustCatAPI api = ComboCustCatAPI();
		return await api.getComboCustCatAPI();
	}
}
