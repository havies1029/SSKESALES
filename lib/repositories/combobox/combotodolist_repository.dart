import 'package:esalesapp/apis/combobox/combotodolist_api.dart';
import 'package:esalesapp/models/combobox/combotodolist_model.dart';

class ComboTodoListRepository {

	Future<List<ComboTodoListModel>> getComboTodoList(String jobCatGroupId, DateTime tgl, String filter) async {
		ComboTodoListAPI api = ComboTodoListAPI();
		return await api.getComboTodoListAPI(jobCatGroupId, tgl, filter);
	}
}
