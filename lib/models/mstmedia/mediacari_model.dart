
class MediaCariModel {
	String mediaNama;
	String mmediaId;

	MediaCariModel({required this.mediaNama, required this.mmediaId});

	factory MediaCariModel.fromJson(Map<String, dynamic> data) {
		return MediaCariModel(
			mediaNama: data['mediaNama']??'',
			mmediaId: data['mmediaId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mediaNama': mediaNama,
		'mmediaId': mmediaId};

}
