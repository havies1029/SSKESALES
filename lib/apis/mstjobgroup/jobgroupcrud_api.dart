import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstjobgroup/jobgroupcrud_model.dart';

class JobGroupCrudAPI {

	Future<ReturnDataAPI> jobGroupCrudTambahAPI(JobGroupCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/mstjobgroup/jobgroupcrud/create";
		Map<String, String> queryParams = {"modul_id": "jobGroupCrudTambahAPI"};
		var uri = AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

		ReturnDataAPI returnData;
		final http.Response response = await http.post(uri,
			headers: <String, String>{
				'Content-Type': 'application/json; odata=verbos',
				'Accept': 'application/json; odata=verbos',
				'Authorization': 'Bearer ${AppData.userToken}'
			},
			body: jsonEncode(record.toJson()));

		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData;
	}
	Future<bool> jobGroupCrudUbahAPI(JobGroupCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/mstjobgroup/jobgroupcrud/update";
		Map<String, String> queryParams = {"modul_id": "jobGroupCrudUbahAPI"};

		var uri = AppData.uriHtpp(AppData.httpAuthority, ubahEndpoint, queryParams);

		final http.Response response = await http.post(uri,
			headers: <String, String>{
				'Content-Type': 'application/json; odata=verbos',
				'Accept': 'application/json; odata=verbos',
				'Authorization': 'Bearer ${AppData.userToken}'
			},
			body: jsonEncode(record.toJson()));

		ReturnDataAPI returnData;
		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData.success;
	}
	Future<bool> jobGroupCrudHapusAPI(String mjobgroupId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/mstjobgroup/jobgroupcrud/delete";
		Map<String, String> queryParams = {
			'mjobgroupId': mjobgroupId,
			'modul_id': 'jobGroupCrudHapusAPI'};
		var uri = AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		ReturnDataAPI returnData;
		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData.success;
	}
	Future<JobGroupCrudModel> jobGroupCrudLihatAPI(String mjobgroupId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/mstjobgroup/jobgroupcrud/read";
		Map<String, String> queryParams = {'mjobgroupId': mjobgroupId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = JobGroupCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}
