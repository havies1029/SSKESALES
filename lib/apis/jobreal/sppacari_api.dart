import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/sppacari_model.dart';

class SppaCariAPI{
	Future<List<SppaCariModel>> getSppaCariAPI(String jobRealId, String searchText, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/jobreal/sppacari/getlist";

		Map<String, String> queryParams = {
      "jobRealId": jobRealId, 
      "searchText": searchText, 
      "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<SppaCariModel>((json) => SppaCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
