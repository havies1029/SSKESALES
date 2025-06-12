import 'package:esalesapp/apis/todo/companylist_api.dart';
import 'package:esalesapp/models/todo/companylist_model.dart';

class CompanyListRepository {

	Future<List<CompanyListModel>> getCompanyList(String timeline1Id, int hal) async {
		CompanyListAPI api = CompanyListAPI();
		return await api.getCompanyListAPI(timeline1Id, hal);
	}
}
