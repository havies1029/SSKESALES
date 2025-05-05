import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';

class PrjtreeCrudModel {
	String prjtree1Id;
	String projectNama;
	String? mmstjobcatId;
	ComboMMstJobcatModel? comboMMstJobcat;
	String? mrekanId;
	ComboCustomerModel? comboCustomer;

	PrjtreeCrudModel({required this.prjtree1Id, required this.projectNama, 
		this.mmstjobcatId, this.comboMMstJobcat, this.mrekanId, this.comboCustomer});

	factory PrjtreeCrudModel.fromJson(Map<String, dynamic> data) {
		ComboMMstJobcatModel? comboMMstJobcat;
		if (data['comboMMstJobcat'] != null) {
			comboMMstJobcat = ComboMMstJobcatModel.fromJson(data['comboMMstJobcat']);
		}

		ComboCustomerModel? comboCustomer;
		if (data['comboCustomer'] != null) {
			comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
		}

		return PrjtreeCrudModel(
			prjtree1Id: data['prjtree1Id']??'',
			projectNama: data['projectNama']??'',
			mmstjobcatId: data['mmstjobcatId']??'',
			comboMMstJobcat: comboMMstJobcat,
			mrekanId: data['mrekanId']??'',
			comboCustomer: comboCustomer
		);

	}

	Map<String, dynamic> toJson() =>
		{'prjtree1Id': prjtree1Id,
		'projectNama': projectNama,
		'mmstjobcatId': mmstjobcatId,
		'comboMMstJobcat': comboMMstJobcat?.toJson(),
		'mrekanId': mrekanId,
		'comboCustomer': comboCustomer?.toJson()};

}
