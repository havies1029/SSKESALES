import 'package:equatable/equatable.dart';

class ComboJabatanModel extends Equatable {
	final String jabatanDesc;
	final String mjabatanId;

	const ComboJabatanModel({this.jabatanDesc='', this.mjabatanId=''});

	factory ComboJabatanModel.fromJson(Map<String, dynamic> data) =>
		ComboJabatanModel(
			jabatanDesc: data['jabatanDesc'],
			mjabatanId: data['mjabatanId']
		);

	Map<String, dynamic> toJson() =>
		{'jabatanDesc': jabatanDesc,
		'mjabatanId': mjabatanId};

	@override
	List<Object> get props => [jabatanDesc, mjabatanId];
}
