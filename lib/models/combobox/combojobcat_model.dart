import 'package:equatable/equatable.dart';

class ComboJobcatModel extends Equatable {
	final String mjobcatId;
	final String catName;

	const ComboJobcatModel({this.mjobcatId='', this.catName=''});

	factory ComboJobcatModel.fromJson(Map<String, dynamic> data) =>
		ComboJobcatModel(
			mjobcatId: data['mjobcatId'],
			catName: data['catName']
		);

	Map<String, dynamic> toJson() =>
		{'mjobcatId': mjobcatId,
		'catName': catName};

	@override
	List<Object> get props => [mjobcatId, catName];
}
