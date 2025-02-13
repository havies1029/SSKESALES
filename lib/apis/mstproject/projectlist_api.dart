import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/mstproject/projectlist_model.dart';

class ProjectListAPI{
	Future<List<ProjectListModel>> getProjectListAPI(String clientId, String searchText, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/mstproject/projectlist/getlist";

		Map<String, String> queryParams = {"clientId":clientId, "searchText": searchText, "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ProjectListModel>((json) => ProjectListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
