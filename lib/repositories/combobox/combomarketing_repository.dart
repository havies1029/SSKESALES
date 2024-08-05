import 'package:esalesapp/apis/combobox/combomarketing_api.dart';
import 'package:esalesapp/models/combobox/combomarketing_model.dart';

class ComboMarketingRepository {

	Future<List<ComboMarketingModel>> getComboMarketing() async {
		ComboMarketingAPI api = ComboMarketingAPI();
		return await api.getComboMarketingAPI();
	}
}
