
class JobCariModel {
	String jobNama;
	String mjobId;
	String? catName;

	JobCariModel({required this.jobNama, required this.mjobId, 
		this.catName});

	factory JobCariModel.fromJson(Map<String, dynamic> data) {
		return JobCariModel(
			jobNama: data['jobNama']??'',
			mjobId: data['mjobId']??'',
			catName: data['catName']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'jobNama': jobNama,
		'mjobId': mjobId,
		'catName': catName};

}
