import 'package:esalesapp/apis/combobox/combojobgroup_api.dart';
import 'package:esalesapp/models/combobox/combojobgroup_model.dart';

class ComboJobGroupRepository {

	Future<List<ComboJobGroupModel>> getComboJobGroup() async {
		ComboJobGroupAPI api = ComboJobGroupAPI();
		return await api.getComboJobGroupAPI();
	}
}
