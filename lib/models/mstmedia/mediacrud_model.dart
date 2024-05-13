
class MediaCrudModel {
	String mediaNama;
	String mmediaId;

	MediaCrudModel({required this.mediaNama, required this.mmediaId});

	factory MediaCrudModel.fromJson(Map<String, dynamic> data) {
		return MediaCrudModel(
			mediaNama: data['mediaNama']??'',
			mmediaId: data['mmediaId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mediaNama': mediaNama,
		'mmediaId': mmediaId};

}
