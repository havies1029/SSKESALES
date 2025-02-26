import 'package:esalesapp/apis/combobox/combommstjobcat_api.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';

class ComboMMstJobcatRepository {

	Future<List<ComboMMstJobcatModel>> getComboMMstJobcat(String mrekanId, String filter) async {
		ComboMMstJobcatAPI api = ComboMMstJobcatAPI();
		return await api.getComboMMstJobcatAPI(mrekanId, filter);
	}
}
