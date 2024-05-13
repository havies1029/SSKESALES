import 'package:esalesapp/apis/mststaff/staffcari_api.dart';
import 'package:esalesapp/models/mststaff/staffcari_model.dart';

class StaffCariRepository {

	Future<List<StaffCariModel>> getStaffCari(String searchText, int hal) async {
		StaffCariAPI api = StaffCariAPI();
		return await api.getStaffCariAPI(searchText, hal);
	}
}
