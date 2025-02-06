import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/mstrekan/rekancontactlist_model.dart';

class RekanContactListAPI{
	Future<List<RekanContactListModel>> getRekanContactListAPI(String mrekanId, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/mstrekan/rekancontactlist/getlist";
    
    debugPrint("RekanContactListAPI #10");

    debugPrint("urlGetListEndPoint : $urlGetListEndPoint");

		Map<String, String> queryParams = {"mrekanId": mrekanId, "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    debugPrint("response.body : ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<RekanContactListModel>((json) => RekanContactListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
