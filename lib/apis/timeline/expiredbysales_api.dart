import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/timeline/expiredbysales_model.dart';

class ExpiredBySalesAPI{
	Future<List<ExpiredBySalesModel>> getExpiredBySalesAPI(String expgroupId) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/timeline/expiredbysales/getlist";
    Map<String, String> queryParams = {
      "expgroup_id": expgroupId,
    };
		var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ExpiredBySalesModel>((json) => ExpiredBySalesModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
