import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/projecttree/prjtreelist_model.dart';

class PrjtreeListAPI{
	Future<List<PrjtreeListModel>> getPrjtreeListAPI(String searchText, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/projecttree/prjtreelist/getlist";

		Map<String, String> queryParams = {"searchText": searchText, "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<PrjtreeListModel>((json) => PrjtreeListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}

  Future<ReturnDataAPI> projectListStartAPI(String mprojectId) async {
    debugPrint("projectListStartAPI");

    String hapusEndpoint =
        "${AppData.prefixEndPoint}/api/projecttree/prjtreelist/startproject";
    Map<String, String> queryParams = {
      'projectId': mprojectId,
      'modul_id': 'projectListStartAPI'
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    ReturnDataAPI returnData;
    debugPrint("projectListStartAPI -> response.statusCode : ${response.statusCode}");
    if (response.statusCode == 200) {
      debugPrint("projectListStartAPI -> response.body : ${response.body}");
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData;
  }
}
