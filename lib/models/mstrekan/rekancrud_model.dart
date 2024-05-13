import 'package:esalesapp/models/combobox/combocustcat_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';

class RekanCrudModel {
  String alamat1;
  String alamat2;
  String mrekanId;
  String mtiperekanId;
  String? mtitleId;
  String rekanNama;
  String telp1;
  String telp2;
  String? mcustcatId;
  ComboTitleModel? comboTitle;
  ComboCustCatModel? comboCustCat;
  ComboJobModel? comboJob;
  ComboMediaModel? comboMedia;

  RekanCrudModel(
      {required this.alamat1,
      required this.alamat2,
      required this.mrekanId,
      this.comboTitle,
      required this.mtiperekanId,
      this.mtitleId,
      required this.rekanNama,
      required this.telp1,
      required this.telp2,
      this.mcustcatId,
      this.comboCustCat,
      this.comboJob,
      this.comboMedia});

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
        comboTitle: comboTitle,
        comboCustCat: comboCustCat,
        comboJob: comboJob,
        comboMedia: comboMedia);
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
        'comboTitle': comboTitle?.toJson(),
        'comboCustCat': comboCustCat?.toJson(),
        'comboJob': comboJob?.toJson(),
        'comboMedia': comboMedia?.toJson()
      };
}
