import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstjob/jobcrud_api.dart';
import 'package:esalesapp/models/mstjob/jobcrud_model.dart';

class JobCrudRepository {

	JobCrudAPI api = JobCrudAPI();

	Future<ReturnDataAPI> jobCrudTambah(JobCrudModel record) async {
		return await api.jobCrudTambahAPI(record);
	}
	Future<bool> jobCrudUbah(JobCrudModel record) async {
		return await api.jobCrudUbahAPI(record);
	}
	Future<bool> jobCrudHapus(String mjobId) async {
		return await api.jobCrudHapusAPI(mjobId);
	}
	Future<JobCrudModel> jobCrudLihat(String mjobId) async {
		return await api.jobCrudLihatAPI(mjobId);
	}
}
