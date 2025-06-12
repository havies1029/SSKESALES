import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/todo/companylist_model.dart';

class CompanyListAPI{
	Future<List<CompanyListModel>> getCompanyListAPI(String timeline1Id, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/todo/companylist/getlist";

		Map<String, String> queryParams = {"timeline1Id": timeline1Id, "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<CompanyListModel>((json) => CompanyListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
