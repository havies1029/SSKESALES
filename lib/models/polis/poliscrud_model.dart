import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';

class PolisCrudModel {
	double cstPremi;
	String insuredNama;
	DateTime periodeAkhir;
	DateTime periodeAwal;
	String polisNo;
	String polis1Id;
	double tsi;
	String? mcobId;
	ComboCobModel? comboCob;
	String? mrekanId;
	ComboCustomerModel? comboCustomer;

	PolisCrudModel({required this.cstPremi, required this.insuredNama, 
		required this.periodeAkhir, required this.periodeAwal, 
		required this.polisNo, required this.polis1Id, 
		required this.tsi, this.mcobId, this.comboCob, 
		this.mrekanId, this.comboCustomer});

	factory PolisCrudModel.fromJson(Map<String, dynamic> data) {
		ComboCobModel? comboCob;
		if (data['comboCob'] != null) {
			comboCob = ComboCobModel.fromJson(data['comboCob']);
		}

		ComboCustomerModel? comboCustomer;
		if (data['comboCustomer'] != null) {
			comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
		}

		return PolisCrudModel(
			cstPremi: double.tryParse(data['cstPremi'].toString())??0,
			insuredNama: data['insuredNama']??'',
			periodeAkhir: DateTime.tryParse(data['periodeAkhir'].toString())??DateTime.now(),
			periodeAwal: DateTime.tryParse(data['periodeAwal'].toString())??DateTime.now(),
			polisNo: data['polisNo']??'',
			polis1Id: data['polis1Id']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			mcobId: data['mcobId']??'',
			comboCob: comboCob,
			mrekanId: data['mrekanId']??'',
			comboCustomer: comboCustomer
		);

	}

	Map<String, dynamic> toJson() =>
		{'cstPremi': cstPremi.toString(),
		'insuredNama': insuredNama,
		'periodeAkhir': periodeAkhir.toIso8601String(),
		'periodeAwal': periodeAwal.toIso8601String(),
		'polisNo': polisNo,
		'polis1Id': polis1Id,
		'tsi': tsi.toString(),
		'mcobId': mcobId,
		'comboCob': comboCob?.toJson(),
		'mrekanId': mrekanId,
		'comboCustomer': comboCustomer?.toJson()};

}
