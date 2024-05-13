
class JobCatCrudModel {
	String catName;
	String mjobcatId;

	JobCatCrudModel({required this.catName, required this.mjobcatId});

	factory JobCatCrudModel.fromJson(Map<String, dynamic> data) {
		return JobCatCrudModel(
			catName: data['catName']??'',
			mjobcatId: data['mjobcatId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'catName': catName,
		'mjobcatId': mjobcatId};

}
