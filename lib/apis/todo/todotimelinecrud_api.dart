import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/todo/todotimelinecrud_model.dart';

class TodoTimelineCrudAPI {

	Future<ReturnDataAPI> todoTimelineCrudTambahAPI(TodoTimelineCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/todo/todotimelinecrud/create";
		Map<String, String> queryParams = {"modul_id": "todoTimelineCrudTambahAPI"};
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
	Future<bool> todoTimelineCrudUbahAPI(TodoTimelineCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/todo/todotimelinecrud/update";
		Map<String, String> queryParams = {"modul_id": "todoTimelineCrudUbahAPI"};

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
	Future<bool> todoTimelineCrudHapusAPI(String timeline1Id) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/todo/todotimelinecrud/delete";
		Map<String, String> queryParams = {
			'timeline1Id': timeline1Id,
			'modul_id': 'todoTimelineCrudHapusAPI'};
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
	Future<TodoTimelineCrudModel> todoTimelineCrudLihatAPI(String timeline1Id) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/todo/todotimelinecrud/read";
		Map<String, String> queryParams = {'timeline1Id': timeline1Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = TodoTimelineCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}
