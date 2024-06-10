import 'package:equatable/equatable.dart';

class ComboJobGroupModel extends Equatable {
	final String mjobgroupId;
	final String groupName;

	const ComboJobGroupModel({this.mjobgroupId='', this.groupName=''});

	factory ComboJobGroupModel.fromJson(Map<String, dynamic> data) =>
		ComboJobGroupModel(
			mjobgroupId: data['mjobgroupId'],
			groupName: data['groupName']
		);

	Map<String, dynamic> toJson() =>
		{'mjobgroupId': mjobgroupId,
		'groupName': groupName};

	@override
	List<Object> get props => [mjobgroupId, groupName];
}
