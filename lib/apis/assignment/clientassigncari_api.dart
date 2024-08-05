import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/assignment/clientassigncari_model.dart';

class ClientAssignCariAPI{
	Future<List<ClientAssignCariModel>> getClientAssignCariAPI() async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/assignment/clientassigncari/getlist";

    Map<String, String> queryParams = {
      "marketingId": AppData.personId
    };

		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ClientAssignCariModel>((json) => ClientAssignCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
