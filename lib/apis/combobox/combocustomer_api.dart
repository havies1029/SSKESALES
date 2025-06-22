import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combocustomer_model.dart';

class ComboCustomerAPI {	

	Future<List<ComboCustomerModel>> getComboCustomerAPI(String filter) async {
    String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mrekancombobox/customer/getlist";
		Map<String, String> queryParams = {"filter": filter};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    //debugPrint("response.statusCode : ${response.statusCode}");
    //debugPrint("response.body : ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ComboCustomerModel>((json) => ComboCustomerModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}

  Future<List<ComboCustomerModel>> getComboCustomer4JobRealAPI(String timeline1Id, String filter) async {
    String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mrekancombobox/customer4jobreal/getlist";
		Map<String, String> queryParams = {"filter": filter, "timelineId": timeline1Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    //debugPrint("response.statusCode : ${response.statusCode}");
    //debugPrint("response.body : ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ComboCustomerModel>((json) => ComboCustomerModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
