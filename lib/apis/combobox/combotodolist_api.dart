import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combotodolist_model.dart';

class ComboTodoListAPI {

	Future<List<ComboTodoListModel>> getComboTodoListAPI(String jobCatGroupId, DateTime tgl, String filter) async {
		String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/timeline1combobox/getlist";
    Map<String, String> queryParams = {"jobCatGroupId": jobCatGroupId, "tgl": tgl.toIso8601String(), "filter": filter};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ComboTodoListModel>((json) => ComboTodoListModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
