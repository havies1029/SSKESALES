import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstproject/projectcrud_api.dart';
import 'package:esalesapp/models/mstproject/projectcrud_model.dart';

class ProjectCrudRepository {

	ProjectCrudAPI api = ProjectCrudAPI();

	Future<ReturnDataAPI> projectCrudTambah(ProjectCrudModel record) async {
		return await api.projectCrudTambahAPI(record);
	}
	Future<bool> projectCrudUbah(ProjectCrudModel record) async {
		return await api.projectCrudUbahAPI(record);
	}
	Future<bool> projectCrudHapus(String mprojectId) async {
		return await api.projectCrudHapusAPI(mprojectId);
	}
	Future<ProjectCrudModel> projectCrudLihat(String mprojectId) async {
		return await api.projectCrudLihatAPI(mprojectId);
	}
}
