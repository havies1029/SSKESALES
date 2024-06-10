import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstjobgroup/jobgroupcrud_api.dart';
import 'package:esalesapp/models/mstjobgroup/jobgroupcrud_model.dart';

class JobGroupCrudRepository {

	JobGroupCrudAPI api = JobGroupCrudAPI();

	Future<ReturnDataAPI> jobGroupCrudTambah(JobGroupCrudModel record) async {
		return await api.jobGroupCrudTambahAPI(record);
	}
	Future<bool> jobGroupCrudUbah(JobGroupCrudModel record) async {
		return await api.jobGroupCrudUbahAPI(record);
	}
	Future<bool> jobGroupCrudHapus(String mjobgroupId) async {
		return await api.jobGroupCrudHapusAPI(mjobgroupId);
	}
	Future<JobGroupCrudModel> jobGroupCrudLihat(String mjobgroupId) async {
		return await api.jobGroupCrudLihatAPI(mjobgroupId);
	}
}
