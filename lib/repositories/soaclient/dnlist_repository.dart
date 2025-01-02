import 'package:esalesapp/apis/soaclient/dnlist_api.dart';
import 'package:esalesapp/models/soaclient/dnlist_model.dart';

class DnlistRepository {

	Future<List<DnlistModel>> getDnlist(String soaAgingId, String searchText, int hal) async {
		DnlistAPI api = DnlistAPI();
		return await api.getDnlistAPI(soaAgingId, searchText, hal);
	}
}
