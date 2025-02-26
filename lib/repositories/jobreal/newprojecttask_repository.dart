import 'package:esalesapp/apis/jobreal/newprojecttaskinitvalue_api.dart';
import 'package:esalesapp/models/jobreal/newprojecttaskinitvalue_model.dart';

class NewProjectTaskRepository {
  Future<NewProjectTaskInitValueModel> getNewProjectReleaseTaskInitValue(
      String plan1Id) async {
    NewProjectTaskInitValueAPI api = NewProjectTaskInitValueAPI();
    return await api.getNewProjectInitValueAPI(plan1Id);
  }
}
