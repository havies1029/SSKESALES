import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstjobcat/jobcatcrud_model.dart';

class JobCatCrudAPI {

	Future<ReturnDataAPI> jobCatCrudTambahAPI(JobCatCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/mstjobcat/jobcatcrud/create";
		Map<String, String> queryParams = {"modul_id": "jobCatCrudTambahAPI"};
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
	Future<bool> jobCatCrudUbahAPI(JobCatCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/mstjobcat/jobcatcrud/update";
		Map<String, String> queryParams = {"modul_id": "jobCatCrudUbahAPI"};

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
	Future<bool> jobCatCrudHapusAPI(String mjobcatId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/mstjobcat/jobcatcrud/delete";
		Map<String, String> queryParams = {
			'mjobcatId': mjobcatId,
			'modul_id': 'jobCatCrudHapusAPI'};
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
	Future<JobCatCrudModel> jobCatCrudLihatAPI(String mjobcatId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/mstjobcat/jobcatcrud/read";
		Map<String, String> queryParams = {'mjobcatId': mjobcatId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = JobCatCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}
