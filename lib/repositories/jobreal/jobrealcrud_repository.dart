import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/jobreal/jobrealcrud_api.dart';
import 'package:esalesapp/models/jobreal/jobrealcrud_model.dart';

class JobRealCrudRepository {

	JobRealCrudAPI api = JobRealCrudAPI();

	Future<ReturnDataAPI> jobRealCrudTambah(JobRealCrudModel record) async {
		return await api.jobRealCrudTambahAPI(record);
	}
	Future<bool> jobRealCrudUbah(JobRealCrudModel record) async {
		return await api.jobRealCrudUbahAPI(record);
	}
	Future<bool> jobRealCrudHapus(String jobreal1Id) async {
		return await api.jobRealCrudHapusAPI(jobreal1Id);
	}
	Future<JobRealCrudModel> jobRealCrudLihat(String jobreal1Id) async {
		return await api.jobRealCrudLihatAPI(jobreal1Id);
	}
}
