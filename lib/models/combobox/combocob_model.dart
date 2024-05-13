import 'package:equatable/equatable.dart';

class ComboCobModel extends Equatable {
	final String mcobId;
	final String cobNama;
	final String shortName;

	const ComboCobModel({this.mcobId='', this.cobNama='', this.shortName=''});

	factory ComboCobModel.fromJson(Map<String, dynamic> data) =>
		ComboCobModel(
			mcobId: data['mcobId'],
			cobNama: data['cobNama'],
			shortName: data['shortName']
		);

	Map<String, dynamic> toJson() =>
		{'mcobId': mcobId,
		'cobNama': cobNama,
		'shortName': shortName};

	@override
	List<Object> get props => [mcobId, cobNama, shortName];
}
