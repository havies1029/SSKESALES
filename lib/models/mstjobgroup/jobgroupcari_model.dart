
class JobGroupCariModel {
	String groupName;
	String mjobgroupId;

	JobGroupCariModel({required this.groupName, required this.mjobgroupId});

	factory JobGroupCariModel.fromJson(Map<String, dynamic> data) {
		return JobGroupCariModel(
			groupName: data['groupName']??'',
			mjobgroupId: data['mjobgroupId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'groupName': groupName,
		'mjobgroupId': mjobgroupId};

}
