import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/projecttree/treenodelist_model.dart';

class TreenodeListAPI{
	Future<List<TreenodeListModel>> getTreenodeListAPI(String prjtree1Id, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/projecttree/treenodelist/getlist";

		Map<String, String> queryParams = {"prjtree1Id": prjtree1Id, "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<TreenodeListModel>((json) => TreenodeListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
