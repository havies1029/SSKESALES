import 'package:esalesapp/apis/projecttree/treenodelist_api.dart';
import 'package:esalesapp/models/projecttree/treenodelist_model.dart';

class TreenodeListRepository {

	Future<List<TreenodeListModel>> getTreenodeList(String prjtree1Id, int hal) async {
		TreenodeListAPI api = TreenodeListAPI();
		return await api.getTreenodeListAPI(prjtree1Id, hal);
	}
}
