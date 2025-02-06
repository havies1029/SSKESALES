import 'package:esalesapp/apis/mstrekan/rekancontactlist_api.dart';
import 'package:esalesapp/models/mstrekan/rekancontactlist_model.dart';

class RekanContactListRepository {

	Future<List<RekanContactListModel>> getRekanContactList(String mrekanId, int hal) async {
		RekanContactListAPI api = RekanContactListAPI();
		return await api.getRekanContactListAPI(mrekanId, hal);
	}
}
