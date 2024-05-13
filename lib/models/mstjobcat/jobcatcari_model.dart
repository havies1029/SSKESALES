
class JobCatCariModel {
	String catName;
	String mjobcatId;

	JobCatCariModel({required this.catName, required this.mjobcatId});

	factory JobCatCariModel.fromJson(Map<String, dynamic> data) {
		return JobCatCariModel(
			catName: data['catName']??'',
			mjobcatId: data['mjobcatId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'catName': catName,
		'mjobcatId': mjobcatId};

}
