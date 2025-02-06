import 'package:esalesapp/models/combobox/combojabatan_model.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';

class RekanContactCrudModel {
  String contactNama;
  String email;
  String mcontactId;
  String noHp;
  String? mrekanId;
  String? mtitleId;
  String? mjabatanId;
  ComboTitleModel? comboTitle;
  ComboJabatanModel? comboJabatan;

  RekanContactCrudModel(
      {required this.contactNama,
      required this.email,
      required this.mcontactId,
      required this.noHp,
      this.mrekanId,
      this.mtitleId,
      this.comboTitle,
      this.mjabatanId,
      this.comboJabatan});

  factory RekanContactCrudModel.fromJson(Map<String, dynamic> data) {
    
    ComboTitleModel? comboTitle;
    if (data['comboTitle'] != null) {
      comboTitle = ComboTitleModel.fromJson(data['comboTitle']);
    }

    ComboJabatanModel? comboJabatan;
    if (data['comboJabatan'] != null) {
      comboJabatan = ComboJabatanModel.fromJson(data['comboJabatan']);
    }

    return RekanContactCrudModel(
      contactNama: data['contactNama'] ?? '',
      email: data['email'] ?? '',
      mcontactId: data['mcontactId'] ?? '',
      noHp: data['noHp'] ?? '',
      mrekanId: data['mrekanId'] ?? '',
      mtitleId: data['mtitleId'] ?? "",
      comboTitle: comboTitle,
      mjabatanId: data['mjabatanId'] ?? "",
      comboJabatan: comboJabatan
    );
  }

  Map<String, dynamic> toJson() => {
        'contactNama': contactNama,
        'email': email,
        'mcontactId': mcontactId,
        'noHp': noHp,
        'mrekanId': mrekanId,        
        'mtitleId': mtitleId,       
        'mjabatanId': mjabatanId,     
        'comboTitle': comboTitle?.toJson(),
        'comboJabatan': comboJabatan?.toJson(),
      };
}
