import 'package:equatable/equatable.dart';

class ComboCustomerModel extends Equatable {
  final String alamat1;
  final String alamat2;
  final String ktpNo;
  final String mrekanId;
  final String rekanNama;
  final String telp1;
  final String telp2;
  final String titleDesc;

  const ComboCustomerModel(
      {this.alamat1 = '',
      this.alamat2 = '',
      this.ktpNo = '',
      this.mrekanId = '',
      this.rekanNama = '',
      this.telp1 = '',
      this.telp2 = '',
      this.titleDesc = ""});

  factory ComboCustomerModel.fromJson(Map<String, dynamic> data) =>
      ComboCustomerModel(
          mrekanId: data['mrekanId'],
          rekanNama: data['rekanNama'],
          alamat1: data['alamat1']??"",
          alamat2: data['alamat2']??"",
          ktpNo: data['ktpNo']??"",
          telp1: data['telp1']??"",
          telp2: data['telp2']??"",
          titleDesc: data['titleDesc']??"");

  Map<String, dynamic> toJson() =>
    {'alamat1': alamat1,
		'alamat2': alamat2,
		'ktpNo': ktpNo,
		'mrekanId': mrekanId,
		'rekanNama': rekanNama,
		'telp1': telp1,
		'telp2': telp2,
		'titleDesc': titleDesc};

  @override
  List<Object> get props => [alamat1, alamat2, ktpNo, mrekanId, rekanNama, telp1, telp2, titleDesc];
}
