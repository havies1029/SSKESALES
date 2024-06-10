
import 'package:string_validator/string_validator.dart';

class JobReal3CariModel {
	String mcobId;
	String cobNama;
  String jobreal3Id;
	bool isChecked = false;

	JobReal3CariModel({required this.mcobId, required this.cobNama,
    required this.isChecked, required this.jobreal3Id});

	factory JobReal3CariModel.fromJson(Map<String, dynamic> data) {
		return JobReal3CariModel(
			mcobId: data['mcobId']??'',
			cobNama: data['cobNama']??'',
      jobreal3Id: data['jobreal3Id'] ?? '',
      isChecked: toBoolean(data['isChecked'].toString())
		);

	}

	Map<String, dynamic> toJson() =>
		{
      'mcobId': mcobId,
      'cobNama': cobNama,
      'jobreal3Id': jobreal3Id,
      'isChecked': isChecked.toString()
    };

}

class JobReal3CariCheckboxModel {
  String mcobId;
  bool isChecked = false;

  JobReal3CariCheckboxModel({required this.mcobId, required this.isChecked});

  factory JobReal3CariCheckboxModel.fromJson(Map<String, dynamic> data) {
    return JobReal3CariCheckboxModel(
        mcobId: data['mcobId'] ?? '', 
        isChecked: toBoolean(data['isChecked'].toString())
        );
  }

  Map<String, dynamic> toJson() =>
      {'mcobId': mcobId, 'isChecked': isChecked.toString()};
}