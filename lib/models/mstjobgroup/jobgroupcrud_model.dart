
class JobGroupCrudModel {
	String groupName;
	String mjobgroupId;

	JobGroupCrudModel({required this.groupName, required this.mjobgroupId});

	factory JobGroupCrudModel.fromJson(Map<String, dynamic> data) {
		return JobGroupCrudModel(
			groupName: data['groupName']??'',
			mjobgroupId: data['mjobgroupId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'groupName': groupName,
		'mjobgroupId': mjobgroupId};

}
