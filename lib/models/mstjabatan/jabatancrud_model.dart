class JabatanCrudModel {
	String jabatanDesc;
	String mjabatanId;

	JabatanCrudModel({required this.jabatanDesc, required this.mjabatanId});

	factory JabatanCrudModel.fromJson(Map<String, dynamic> data) =>
		JabatanCrudModel(
			jabatanDesc: data['jabatanDesc'],
			mjabatanId: data['mjabatanId']
		);

	Map<String, dynamic> toJson() =>
		{'jabatanDesc': jabatanDesc,
		'mjabatanId': mjabatanId};

}
