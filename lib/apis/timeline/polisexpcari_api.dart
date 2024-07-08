import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/timeline/polisexpcari_model.dart';

class PolisExpCariAPI{
	Future<List<PolisExpCariModel>> getPolisExpCariAPI(String searchText, int hal,
    String expgroupId, String personalId) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/timeline/polisexpcari/getlist";
    Map<String, String> queryParams = {
      "searchText": searchText,
      "hal": hal.toString(),
      "expgroupId": expgroupId,
      "personalId": personalId,
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
				.map<PolisExpCariModel>((json) => PolisExpCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
