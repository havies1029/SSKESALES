import 'package:esalesapp/apis/combobox/combocustomer_api.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';

class ComboCustomerRepository {

	Future<List<ComboCustomerModel>> getComboCustomer(String filter) async {
		ComboCustomerAPI api = ComboCustomerAPI();
		return await api.getComboCustomerAPI(filter);
	}

  Future<List<ComboCustomerModel>> getComboCustomer4JobReal(String timeline1Id, String filter) async {
		ComboCustomerAPI api = ComboCustomerAPI();
		return await api.getComboCustomer4JobRealAPI(timeline1Id, filter);
	}
}
