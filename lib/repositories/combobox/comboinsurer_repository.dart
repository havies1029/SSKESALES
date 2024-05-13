import 'package:esalesapp/apis/combobox/comboinsurer_api.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';

class ComboInsurerRepository {

	Future<List<ComboInsurerModel>> getComboInsurer(String filter) async {
		return await getComboInsurerAPI(filter);
	}
}
