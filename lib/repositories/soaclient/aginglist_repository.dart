import 'package:esalesapp/apis/soaclient/aginglist_api.dart';
import 'package:esalesapp/models/soaclient/aginglist_model.dart';

class AginglistRepository {

	Future<List<AginglistModel>> getAginglist() async {
		AginglistAPI api = AginglistAPI();
		return await api.getAginglistAPI();
	}
}
