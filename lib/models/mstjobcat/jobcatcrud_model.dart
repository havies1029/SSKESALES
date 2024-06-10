import 'package:esalesapp/models/combobox/combocustcat_model.dart';

class JobCatCrudModel {
  String catName;
  String mjobcatId;
  String mcustcatId;
  ComboCustCatModel? comboCustCat;

  JobCatCrudModel(
  {required this.catName, required this.mjobcatId, required this.mcustcatId, 
    this.comboCustCat});

  factory JobCatCrudModel.fromJson(Map<String, dynamic> data) {
    ComboCustCatModel? comboCustCat;
    if (data['comboCustCat'] != null) {
      comboCustCat = ComboCustCatModel.fromJson(data['comboCustCat']);
    }

    return JobCatCrudModel(
      catName: data['catName'] ?? '',
      mjobcatId: data['mjobcatId'] ?? '',
      mcustcatId: data['mcustcatId'] ?? '',
      comboCustCat: comboCustCat,
    );
  }

  Map<String, dynamic> toJson() => {
        'catName': catName,
        'mjobcatId': mjobcatId,
        'mcustcatId': mcustcatId,
        'comboCustCat': comboCustCat?.toJson(),
      };
}
