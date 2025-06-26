import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/todo/todotimelinelist_model.dart';

class TodoTimelineListAPI{
	Future<List<TodoTimelineListModel>> getTodoTimelineListAPI(DateTime tgl1, String calendarView) async {

    debugPrint("getTodoTimelineListAPI: $tgl1 - $calendarView");

		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/todo/todotimelinelist/getlist";

		Map<String, String> queryParams = {"tgl1": tgl1.toIso8601String(), "calendarView": calendarView};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    //debugPrint("getTodoTimelineListAPI: ${response.statusCode} - ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<TodoTimelineListModel>((json) => TodoTimelineListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
