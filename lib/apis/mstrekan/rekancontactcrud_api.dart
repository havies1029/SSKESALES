import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstrekan/rekancontactcrud_model.dart';

class RekanContactCrudAPI {

	Future<ReturnDataAPI> rekanContactCrudTambahAPI(RekanContactCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/mstrekan/rekancontactcrud/create";
		Map<String, String> queryParams = {"modul_id": "rekanContactCrudTambahAPI"};
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
	Future<bool> rekanContactCrudUbahAPI(RekanContactCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/mstrekan/rekancontactcrud/update";
		Map<String, String> queryParams = {"modul_id": "rekanContactCrudUbahAPI"};

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
	Future<bool> rekanContactCrudHapusAPI(String mcontactId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/mstrekan/rekancontactcrud/delete";
		Map<String, String> queryParams = {
			'mcontactId': mcontactId,
			'modul_id': 'rekanContactCrudHapusAPI'};
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
	Future<RekanContactCrudModel> rekanContactCrudLihatAPI(String mcontactId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/mstrekan/rekancontactcrud/read";
		Map<String, String> queryParams = {'mcontactId': mcontactId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = RekanContactCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}
