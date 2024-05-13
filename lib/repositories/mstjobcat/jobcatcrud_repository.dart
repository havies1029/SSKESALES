import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstjobcat/jobcatcrud_api.dart';
import 'package:esalesapp/models/mstjobcat/jobcatcrud_model.dart';

class JobCatCrudRepository {

	JobCatCrudAPI api = JobCatCrudAPI();

	Future<ReturnDataAPI> jobCatCrudTambah(JobCatCrudModel record) async {
		return await api.jobCatCrudTambahAPI(record);
	}
	Future<bool> jobCatCrudUbah(JobCatCrudModel record) async {
		return await api.jobCatCrudUbahAPI(record);
	}
	Future<bool> jobCatCrudHapus(String mjobcatId) async {
		return await api.jobCatCrudHapusAPI(mjobcatId);
	}
	Future<JobCatCrudModel> jobCatCrudLihat(String mjobcatId) async {
		return await api.jobCatCrudLihatAPI(mjobcatId);
	}
}
