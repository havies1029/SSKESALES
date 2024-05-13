import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/jobreal/jobrealcrud_model.dart';

class JobRealCrudAPI {

	Future<ReturnDataAPI> jobRealCrudTambahAPI(JobRealCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/create";
		Map<String, String> queryParams = {"modul_id": "jobRealCrudTambahAPI"};
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
	Future<bool> jobRealCrudUbahAPI(JobRealCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/update";
		Map<String, String> queryParams = {"modul_id": "jobRealCrudUbahAPI"};

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
	Future<bool> jobRealCrudHapusAPI(String jobreal1Id) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/delete";
		Map<String, String> queryParams = {
			'jobreal1Id': jobreal1Id,
			'modul_id': 'jobRealCrudHapusAPI'};
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
	Future<JobRealCrudModel> jobRealCrudLihatAPI(String jobreal1Id) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/read";
		Map<String, String> queryParams = {'jobreal1Id': jobreal1Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    
    debugPrint("jobRealCrudLihatAPI");
    debugPrint("response.body : ${response.body}");

		if (response.statusCode == 200) {
			var returnData = JobRealCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}
