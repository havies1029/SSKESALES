import 'package:esalesapp/apis/mstrekan/rekancari_api.dart';
import 'package:esalesapp/models/mstrekan/rekancari_model.dart';

class RekanCariRepository {

	Future<List<RekanCariModel>> getRekanCari(String rekanTypeId, String searchText, 
    bool filterUnassigned, int hal) async {
		RekanCariAPI api = RekanCariAPI();
		return await api.getRekanCariAPI(rekanTypeId, searchText, filterUnassigned, hal);
	}
}
