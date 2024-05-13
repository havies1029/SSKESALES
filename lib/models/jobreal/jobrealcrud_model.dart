import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';

class JobRealCrudModel {
	String? hasil;
	String? jobreal1Id;
	String? materi;
	String? picName;
	DateTime? realJam;
	DateTime? realTgl;
	String? mjobId;
	ComboJobModel? comboJob;
	String? mjobcatId;
	ComboJobcatModel? comboJobcat;
	String? mmediaId;
	ComboMediaModel? comboMedia;
	String? mrekanId;
	ComboCustomerModel? comboCustomer;

	JobRealCrudModel({this.hasil, this.jobreal1Id, this.materi, 
    this.picName, this.realJam, this.realTgl, 
    this.mjobId, this.comboJob, this.mjobcatId, 
    this.comboJobcat, this.mmediaId, this.comboMedia, 
    this.mrekanId, this.comboCustomer});

	factory JobRealCrudModel.fromJson(Map<String, dynamic> data) {
		ComboJobModel? comboJob;
		if (data['comboJob'] != null) {
			comboJob = ComboJobModel.fromJson(data['comboJob']);
		}

		ComboJobcatModel? comboJobcat;
		if (data['comboJobcat'] != null) {
			comboJobcat = ComboJobcatModel.fromJson(data['comboJobcat']);
		}

		ComboMediaModel? comboMedia;
		if (data['comboMedia'] != null) {
			comboMedia = ComboMediaModel.fromJson(data['comboMedia']);
		}

		ComboCustomerModel? comboCustomer;
		if (data['comboCustomer'] != null) {
			comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
		}

		return JobRealCrudModel(
			hasil: data['hasil']??'',
			jobreal1Id: data['jobreal1Id']??'',
			materi: data['materi']??'',
			picName: data['picName']??'',
			realJam: DateTime.tryParse(data['realJam'].toString())??DateTime.now(),
			realTgl: DateTime.tryParse(data['realTgl'].toString())??DateTime.now(),
			mjobId: data['mjobId']??'',
			comboJob: comboJob,
			mjobcatId: data['mjobcatId']??'',
			comboJobcat: comboJobcat,
			mmediaId: data['mmediaId']??'',
			comboMedia: comboMedia,
			mrekanId: data['mrekanId']??'',
			comboCustomer: comboCustomer
		);

	}

	Map<String, dynamic> toJson() =>
		{'hasil': hasil,
		'jobreal1Id': jobreal1Id,
		'materi': materi,
		'picName': picName,
		'realJam': realJam?.toIso8601String(),
		'realTgl': realTgl?.toIso8601String(),
		'mjobId': mjobId,
		'comboJob': comboJob?.toJson(),
		'mjobcatId': mjobcatId,
		'comboJobcat': comboJobcat?.toJson(),
		'mmediaId': mmediaId,
		'comboMedia': comboMedia?.toJson(),
		'mrekanId': mrekanId,
		'comboCustomer': comboCustomer?.toJson()};

}
