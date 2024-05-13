import 'package:equatable/equatable.dart';

class ComboMediaModel extends Equatable {
	final String mmediaId;
	final String mediaNama;

	const ComboMediaModel({this.mmediaId='', this.mediaNama=''});

	factory ComboMediaModel.fromJson(Map<String, dynamic> data) =>
		ComboMediaModel(
			mmediaId: data['mmediaId'],
			mediaNama: data['mediaNama']
		);

	Map<String, dynamic> toJson() =>
		{'mmediaId': mmediaId,
		'mediaNama': mediaNama};

	@override
	List<Object> get props => [mmediaId, mediaNama];
}
