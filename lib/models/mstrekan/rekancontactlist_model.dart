
class RekanContactListModel {
	String contactNama;
	String email;
	String mcontactId;
	String jabatanNama;
	String noHp;
	String titleDesc;

	RekanContactListModel({required this.contactNama, required this.email, 
		required this.mcontactId, required this.jabatanNama, 
		required this.noHp, required this.titleDesc});

	factory RekanContactListModel.fromJson(Map<String, dynamic> data) {
		return RekanContactListModel(
			contactNama: data['contactNama']??'',
			email: data['email']??'',
			mcontactId: data['mcontactId']??'',
			jabatanNama: data['jabatanNama']??'',
			noHp: data['noHp']??'',
			titleDesc: data['titleDesc']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'contactNama': contactNama,
		'email': email,
		'mcontactId': mcontactId,
		'jabatanNama': jabatanNama,
		'noHp': noHp,
		'titleDesc': titleDesc};

}
