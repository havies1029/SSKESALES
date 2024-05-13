import 'package:esalesapp/apis/mstjabatan/jabatancari_api.dart';
import 'package:esalesapp/models/mstjabatan/jabatancari_model.dart';

class JabatanCariRepository {

	Future<List<JabatanCariModel>> getJabatanCari(String searchText, int hal) async {
		JabatanCariAPI api = JabatanCariAPI();
		return await api.getJabatanCariAPI(searchText, hal);
	}
}
