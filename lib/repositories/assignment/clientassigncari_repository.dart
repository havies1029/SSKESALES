import 'package:esalesapp/apis/assignment/clientassigncari_api.dart';
import 'package:esalesapp/models/assignment/clientassigncari_model.dart';

class ClientAssignCariRepository {

	Future<List<ClientAssignCariModel>> getClientAssignCari() async {
		ClientAssignCariAPI api = ClientAssignCariAPI();
		return await api.getClientAssignCariAPI();
	}
}
