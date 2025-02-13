import 'package:esalesapp/apis/mstproject/projectlist_api.dart';
import 'package:esalesapp/models/mstproject/projectlist_model.dart';

class ProjectListRepository {

	Future<List<ProjectListModel>> getProjectList(String clientId, String searchText, int hal) async {
		ProjectListAPI api = ProjectListAPI();
		return await api.getProjectListAPI(clientId, searchText, hal);
	}
}
