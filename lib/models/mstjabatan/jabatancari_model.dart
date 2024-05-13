class JabatanCariModel {
	String jabatanDesc;
	String mjabatanId;

	JabatanCariModel({required this.jabatanDesc, required this.mjabatanId});

	factory JabatanCariModel.fromJson(Map<String, dynamic> data) =>
		JabatanCariModel(
			jabatanDesc: data['jabatanDesc'],
			mjabatanId: data['mjabatanId']
		);

	Map<String, dynamic> toJson() =>
		{'jabatanDesc': jabatanDesc,
		'mjabatanId': mjabatanId};

}
