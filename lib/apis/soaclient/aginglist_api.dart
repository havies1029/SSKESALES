import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/soaclient/aginglist_model.dart';

class AginglistAPI{
	Future<List<AginglistModel>> getAginglistAPI() async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/soaclient/aginglist/getlist";

		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<AginglistModel>((json) => AginglistModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
