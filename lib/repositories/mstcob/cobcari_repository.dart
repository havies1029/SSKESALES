import 'package:esalesapp/apis/mstcob/cobcari_api.dart';
import 'package:esalesapp/models/mstcob/cobcari_model.dart';

class CobCariRepository {

	Future<List<CobCariModel>> getCobCari(String searchText, int hal) async {
		CobCariAPI api = CobCariAPI();
		return await api.getCobCariAPI(searchText, hal);
	}
}
