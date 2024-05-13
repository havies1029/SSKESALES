import 'package:esalesapp/apis/combobox/combotitle_api.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';

class ComboTitleRepository {

	Future<List<ComboTitleModel>> getComboTitle(String filter) async {
		return await getComboTitleAPI(filter);
	}
}
