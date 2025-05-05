import 'package:esalesapp/apis/projecttree/prjtreelist_api.dart';
import 'package:esalesapp/models/projecttree/prjtreelist_model.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';

class PrjtreeListRepository {

  PrjtreeListAPI api = PrjtreeListAPI();

	Future<List<PrjtreeListModel>> getPrjtreeList(String searchText, int hal) async {		
		return await api.getPrjtreeListAPI(searchText, hal);
	}

  Future<ReturnDataAPI> projectStart(String mprojectId) async {
		return await api.projectListStartAPI(mprojectId);
	}
}
