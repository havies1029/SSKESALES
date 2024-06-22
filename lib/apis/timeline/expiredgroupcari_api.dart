import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/timeline/expiredgroupcari_model.dart';

class ExpiredGroupCariAPI{
	Future<List<ExpiredGroupCariModel>> getExpiredGroupCariAPI() async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/timeline/expiredgroupcari/getlist";

		var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ExpiredGroupCariModel>((json) => ExpiredGroupCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
