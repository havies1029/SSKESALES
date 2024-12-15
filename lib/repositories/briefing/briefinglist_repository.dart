import 'package:esalesapp/apis/briefing/briefinglist_api.dart';
import 'package:esalesapp/models/briefing/briefinglist_model.dart';

class BriefinglistRepository {
  Future<List<BriefinglistModel>> getBriefinglist() async {
    //debugPrint("BriefinglistRepository #10");
    BriefinglistAPI api = BriefinglistAPI();
    return await api.getBriefinglistAPI();
  }

  Future<bool> checkHasPassedTodaysBriefing() async {
    BriefinglistAPI api = BriefinglistAPI();
    return await api.checkHasPassedTodaysBriefing();
  }
}
