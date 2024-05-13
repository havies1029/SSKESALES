import 'package:equatable/equatable.dart';

class ComboCustCatModel extends Equatable {
	final String mcustcatId;
	final String catName;

	const ComboCustCatModel({this.mcustcatId='', this.catName=''});

	factory ComboCustCatModel.fromJson(Map<String, dynamic> data) =>
		ComboCustCatModel(
			mcustcatId: data['mcustcatId'],
			catName: data['catName']
		);

	Map<String, dynamic> toJson() =>
		{'mcustcatId': mcustcatId,
		'catName': catName};

	@override
	List<Object> get props => [mcustcatId, catName];
}
