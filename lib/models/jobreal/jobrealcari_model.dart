
class JobRealCariModel {
	String hasil;
	String jobreal1Id;
	String materi;
	String picName;
	DateTime realJam;
	DateTime realTgl;
	String? catName;
	String? jobNama;
	String? mediaNama;
  String customerNama;

	JobRealCariModel({required this.hasil, required this.jobreal1Id, 
		required this.materi, required this.picName, 
		required this.realJam, required this.realTgl, 
		this.catName, this.jobNama, 
		this.mediaNama, required this.customerNama});

	factory JobRealCariModel.fromJson(Map<String, dynamic> data) {
		return JobRealCariModel(
			hasil: data['hasil']??'',
			jobreal1Id: data['jobreal1Id']??'',
			materi: data['materi']??'',
			picName: data['picName']??'',
			realJam: DateTime.tryParse(data['realJam'].toString())??DateTime.now(),
			realTgl: DateTime.tryParse(data['realTgl'].toString())??DateTime.now(),
			catName: data['catName']??'',
			jobNama: data['jobNama']??'',
			mediaNama: data['mediaNama']??'',
			customerNama: data['customerNama']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'hasil': hasil,
		'jobreal1Id': jobreal1Id,
		'materi': materi,
		'picName': picName,
		'realJam': realJam.toIso8601String(),
		'realTgl': realTgl.toIso8601String(),
		'catName': catName,
		'jobNama': jobNama,
		'mediaNama': mediaNama,
		'customerNama': customerNama};

}
