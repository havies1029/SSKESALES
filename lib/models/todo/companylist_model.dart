
class CompanyListModel {
	String mrekanId;
	String timeline1Id;
	String timeline2Id;

	CompanyListModel({required this.mrekanId, required this.timeline1Id, 
		required this.timeline2Id});

	factory CompanyListModel.fromJson(Map<String, dynamic> data) {
		return CompanyListModel(
			mrekanId: data['mrekanId']??'',
			timeline1Id: data['timeline1Id']??'',
			timeline2Id: data['timeline2Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mrekanId': mrekanId,
		'timeline1Id': timeline1Id,
		'timeline2Id': timeline2Id};

}
