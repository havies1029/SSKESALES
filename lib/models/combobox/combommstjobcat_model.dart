import 'package:equatable/equatable.dart';

class ComboMMstJobcatModel extends Equatable {
	final String mmstjobcatId;
	final String catName;

	const ComboMMstJobcatModel({this.mmstjobcatId='', this.catName=''});

	factory ComboMMstJobcatModel.fromJson(Map<String, dynamic> data) =>
		ComboMMstJobcatModel(
			mmstjobcatId: data['mmstjobcatId'],
			catName: data['catName'],
		);

	Map<String, dynamic> toJson() =>
		{'mmstjobcatId': mmstjobcatId,
		'catName': catName,};

	@override
	List<Object> get props => [mmstjobcatId, catName];
}
