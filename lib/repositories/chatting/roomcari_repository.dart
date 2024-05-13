import 'package:esalesapp/apis/chatting/roomcari_api.dart';
import 'package:esalesapp/models/chatting/roomcari_model.dart';

class RoomCariRepository {

	Future<List<RoomCariModel>> getRoomCari(String searchText, int hal) async {
		return await getRoomCariAPI(searchText, hal);
	}
}
