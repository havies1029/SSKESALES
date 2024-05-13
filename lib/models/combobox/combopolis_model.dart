import 'package:equatable/equatable.dart';

class ComboPolisModel extends Equatable {
	final String polis1Id;
	final String placing1Id;
	final String mcobId;
	final String polisNo;
	final String coverNo;
	final String insuredNama;
	final String mrekanId;
	final String salesId;
	final String cobNama;

	const ComboPolisModel({this.polis1Id='', this.placing1Id='', this.mcobId='', this.polisNo='', this.coverNo='', this.insuredNama='', this.mrekanId='', this.salesId='', this.cobNama=''});

	factory ComboPolisModel.fromJson(Map<String, dynamic> data) =>
		ComboPolisModel(
			polis1Id: data['polis1Id'],
			placing1Id: data['placing1Id'],
			mcobId: data['mcobId'],
			polisNo: data['polisNo'],
			coverNo: data['coverNo'],
			insuredNama: data['insuredNama'],
			mrekanId: data['mrekanId'],
			salesId: data['salesId'],
			cobNama: data['cobNama']
		);

	Map<String, dynamic> toJson() =>
		{'polis1Id': polis1Id,
		'placing1Id': placing1Id,
		'mcobId': mcobId,
		'polisNo': polisNo,
		'coverNo': coverNo,
		'insuredNama': insuredNama,
		'mrekanId': mrekanId,
		'salesId': salesId,
		'cobNama': cobNama};

	@override
	List<Object> get props => [polis1Id, placing1Id, mcobId, polisNo, coverNo, insuredNama, mrekanId, salesId, cobNama];
}
