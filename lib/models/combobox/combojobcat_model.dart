import 'package:equatable/equatable.dart';

class ComboJobcatModel extends Equatable {
	final String mjobcatId;
	final String catName;
	final String mjobcatdoctypeId;

	const ComboJobcatModel({this.mjobcatId='', this.catName='', this.mjobcatdoctypeId=''});

	factory ComboJobcatModel.fromJson(Map<String, dynamic> data) =>
		ComboJobcatModel(
			mjobcatId: data['mjobcatId'],
			catName: data['catName'],
			mjobcatdoctypeId: data['mjobcatdoctypeId']??""
		);

	Map<String, dynamic> toJson() =>
		{'mjobcatId': mjobcatId,
		'catName': catName,
    'mjobcatdoctypeId': mjobcatdoctypeId};

	@override
	List<Object> get props => [mjobcatId, catName, mjobcatdoctypeId];
}
