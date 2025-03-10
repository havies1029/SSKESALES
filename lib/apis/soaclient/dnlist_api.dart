import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/soaclient/dnlist_model.dart';

class DnlistAPI{
	Future<List<DnlistModel>> getDnlistAPI(String soaAgingId, String searchText, int hal) async {

    Map<String, String> queryParams = {
      "soaging_id": soaAgingId,
      "searchText": searchText,
      "hal": hal.toString()
    };

		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/soaclient/dnlist/getlist";

		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<DnlistModel>((json) => DnlistModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
