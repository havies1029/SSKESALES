import 'package:esalesapp/models/combobox/combocustomer_model.dart';

class CompanyCrudModel {
	String timeline2Id;
	String? mrekanId;
	ComboCustomerModel? comboCustomer;
	String timeline1Id;

	CompanyCrudModel({required this.timeline2Id, this.mrekanId, this.comboCustomer, 
		required this.timeline1Id});

	factory CompanyCrudModel.fromJson(Map<String, dynamic> data) {
		ComboCustomerModel? comboCustomer;
		if (data['comboCustomer'] != null) {
			comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
		}

		return CompanyCrudModel(
			timeline2Id: data['timeline2Id']??'',
			mrekanId: data['mrekanId']??'',
			comboCustomer: comboCustomer,
			timeline1Id: data['timeline1Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'timeline2Id': timeline2Id,
		'mrekanId': mrekanId,
		'comboCustomer': comboCustomer?.toJson(),
		'timeline1Id': timeline1Id};

}
