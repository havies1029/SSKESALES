import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combojabatan_model.dart';

String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mjabatancombobox/getlist";

Future<List<ComboJabatanModel>> getComboJabatanAPI(String filter) async {
	Map<String, String> queryParams = {"filter": filter};
	var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);
	final http.Response response = await http.get(uri, headers: <String, String>{
		'Content-Type': 'application/json; odata=verbos',
		'Accept': 'application/json; odata=verbos',
		'Authorization': 'Bearer ${AppData.userToken}'
	});

	if (response.statusCode == 200) {
		final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
		return parsed
			.map<ComboJabatanModel>((json) => ComboJabatanModel.fromJson(json))
			.toList();
	} else {
		throw Exception("Failed to load data");
	}
}
