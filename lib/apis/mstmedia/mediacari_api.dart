import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/mstmedia/mediacari_model.dart';

class MediaCariAPI{
	String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/mstmedia/mediacari/getlist";

	Future<List<MediaCariModel>> getMediaCariAPI(String searchText, int hal) async {
		Map<String, String> queryParams = {"searchText": searchText, "hal": hal.toString()};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<MediaCariModel>((json) => MediaCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
