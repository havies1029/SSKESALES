import 'package:esalesapp/apis/mstproject/projectlist_api.dart';
import 'package:esalesapp/models/mstproject/projectlist_model.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';

class ProjectListRepository {
  ProjectListAPI api = ProjectListAPI();

	Future<List<ProjectListModel>> getProjectList(String clientId, String searchText, int hal) async {
		
		return await api.getProjectListAPI(clientId, searchText, hal);
	}

  Future<ReturnDataAPI> projectStart(String mprojectId) async {
		return await api.projectListStartAPI(mprojectId);
	}
}
