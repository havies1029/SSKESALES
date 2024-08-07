import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combomarketing_model.dart';

class ComboMarketingAPI {

	Future<List<ComboMarketingModel>> getComboMarketingAPI() async {
		String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/msalescombobox/getlist";

		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ComboMarketingModel>((json) => ComboMarketingModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
