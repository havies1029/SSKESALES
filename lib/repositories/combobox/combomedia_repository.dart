import 'package:esalesapp/apis/combobox/combomedia_api.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';

class ComboMediaRepository {

	Future<List<ComboMediaModel>> getComboMedia() async {
		ComboMediaAPI api = ComboMediaAPI();
		return await api.getComboMediaAPI();
	}
}
