import 'package:esalesapp/apis/jobreal/jobreal3cari_api.dart';
import 'package:esalesapp/models/jobreal/jobreal3cari_model.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';

class JobReal3CariRepository {

	Future<List<JobReal3CariModel>> getJobReal3Cari(String jobreal1Id, String searchText, int hal) async {
		debugPrint("getJobReal3Cari");  
    JobReal3CariAPI api = JobReal3CariAPI();
		return await api.getJobReal3CariAPI(jobreal1Id, searchText, hal);
	}

  Future<ReturnDataAPI> jobReal3UpdateList(
      String jobreal1Id, List<JobReal3CariCheckboxModel> listChecked) async {
    JobReal3CariAPI api = JobReal3CariAPI();
    return api.jobReal3UpdateListAPI(jobreal1Id, listChecked);
  }

  Future<List<JobReal3CariModel>> getJobReal3Grid(String jobreal1Id) async {
    JobReal3CariAPI api = JobReal3CariAPI();
    return await api.getJobReal3GridAPI(jobreal1Id);
  }
}
