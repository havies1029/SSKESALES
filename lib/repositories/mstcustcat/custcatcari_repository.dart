import 'package:esalesapp/apis/mstcustcat/custcatcari_api.dart';
import 'package:esalesapp/models/mstcustcat/custcatcari_model.dart';

class CustCatCariRepository {

	Future<List<CustCatCariModel>> getCustCatCari(String searchText, int hal) async {
		CustCatCariAPI api = CustCatCariAPI();
		return await api.getCustCatCariAPI(searchText, hal);
	}
}
