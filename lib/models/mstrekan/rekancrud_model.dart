import 'package:esalesapp/models/combobox/combocustcat_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combomarketing_model.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';

class RekanCrudModel {
  String? alamat1;
  String? alamat2;
  String mrekanId;
  String mtiperekanId;
  String? mtitleId;
  String rekanNama;
  String? telp1;
  String? telp2;
  String? mcustcatId;
  String? msalesId;
  String? referralFrom;
  DateTime? referralTgl;
  ComboTitleModel? comboTitle;
  ComboCustCatModel? comboCustCat;
  ComboJobModel? comboJob;
  ComboMediaModel? comboMedia;
  ComboMarketingModel? comboMarketing;
  ComboCustomerModel? comboReferral;

  RekanCrudModel(
      {this.alamat1,
      this.alamat2,
      required this.mrekanId,
      this.comboTitle,
      required this.mtiperekanId,
      this.mtitleId,
      required this.rekanNama,
      this.telp1,
      this.telp2,
      this.mcustcatId,
      this.msalesId,
      this.referralTgl,
      this.comboCustCat,
      this.comboJob,
      this.comboMedia,
      this.comboMarketing,
      this.referralFrom,
      this.comboReferral});

  factory RekanCrudModel.fromJson(Map<String, dynamic> data) {
    ComboTitleModel? comboTitle;
    if (data['comboTitle'] != null) {
      comboTitle = ComboTitleModel.fromJson(data['comboTitle']);
    }

    ComboCustCatModel? comboCustCat;
    if (data['comboCustCat'] != null) {
      comboCustCat = ComboCustCatModel.fromJson(data['comboCustCat']);
    }

    ComboJobModel? comboJob;
    if (data['comboJob'] != null) {
      comboJob = ComboJobModel.fromJson(data['comboJob']);
    }

    ComboMediaModel? comboMedia;
    if (data['comboMedia'] != null) {
      comboMedia = ComboMediaModel.fromJson(data['comboMedia']);
    }

    ComboMarketingModel? comboMarketing;
    if (data['comboMarketing'] != null) {
      comboMarketing = ComboMarketingModel.fromJson(data['comboMarketing']);
    }

    ComboCustomerModel? comboReferral;
    if (data['comboReferral'] != null) {
      comboReferral = ComboCustomerModel.fromJson(data['comboReferral']);
    }

    return RekanCrudModel(
        alamat1: data['alamat1'] ?? "",
        alamat2: data['alamat2'] ?? "",
        mrekanId: data['mrekanId'],
        mtiperekanId: data['mtiperekanId'],
        mtitleId: data['mtitleId'] ?? "",
        rekanNama: data['rekanNama'] ?? "",
        telp1: data['telp1'] ?? "",
        telp2: data['telp2'] ?? "",
        mcustcatId: data['mcustcatId'] ?? "",
        msalesId: data['msalesId'] ?? "",
        referralFrom: data['referralFrom'] ?? "",
        referralTgl: data['referralTgl'] != null
            ? DateTime.parse(data['referralTgl'])
            : null,
        comboTitle: comboTitle,
        comboCustCat: comboCustCat,
        comboJob: comboJob,
        comboMedia: comboMedia,
        comboMarketing: comboMarketing,
        comboReferral: comboReferral);
  }

  Map<String, dynamic> toJson() => {
        'alamat1': alamat1,
        'alamat2': alamat2,
        'mrekanId': mrekanId,
        'mtiperekanId': mtiperekanId,
        'mtitleId': mtitleId,
        'rekanNama': rekanNama,
        'telp1': telp1,
        'telp2': telp2,
        'mcustcatId': mcustcatId,
        'msalesId': msalesId,
        'referralFrom': referralFrom,
        'referralTgl': referralTgl?.toIso8601String(),
        'comboTitle': comboTitle?.toJson(),
        'comboCustCat': comboCustCat?.toJson(),
        'comboJob': comboJob?.toJson(),
        'comboMedia': comboMedia?.toJson(),
        'comboMarketing': comboMarketing?.toJson(),
        'comboReferral': comboReferral?.toJson()
      };
}
