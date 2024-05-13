import 'package:equatable/equatable.dart';

class ComboInsurerModel extends Equatable {
	final String alamat1;
	final String alamat2;
	final String ktpNo;
	final String mrekanId;
	final String rekanNama;
	final String telp1;
	final String telp2;

	const ComboInsurerModel({this.alamat1='', this.alamat2='', this.ktpNo='', this.mrekanId='', this.rekanNama='', this.telp1='', this.telp2=''});

	factory ComboInsurerModel.fromJson(Map<String, dynamic> data) =>
		ComboInsurerModel(
			alamat1: data['alamat1']??"",
			alamat2: data['alamat2']??"",
			ktpNo: data['ktpNo']??"",
			mrekanId: data['mrekanId'],
			rekanNama: data['rekanNama'],
			telp1: data['telp1']??"",
			telp2: data['telp2']??""
		);

	Map<String, dynamic> toJson() =>
		{'alamat1': alamat1,
		'alamat2': alamat2,
		'ktpNo': ktpNo,
		'mrekanId': mrekanId,
		'rekanNama': rekanNama,
		'telp1': telp1,
		'telp2': telp2};

	@override
	List<Object> get props => [alamat1, alamat2, ktpNo, mrekanId, rekanNama, telp1, telp2];
}
