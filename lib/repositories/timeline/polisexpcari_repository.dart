import 'package:esalesapp/apis/timeline/polisexpcari_api.dart';
import 'package:esalesapp/models/timeline/polisexpcari_model.dart';

class PolisExpCariRepository {

	Future<List<PolisExpCariModel>> getPolisExpCari(String searchText, int hal,
    String expgroupId, String personalId) async {
		PolisExpCariAPI api = PolisExpCariAPI();
		return await api.getPolisExpCariAPI(searchText, hal, expgroupId, personalId);
	}
}
