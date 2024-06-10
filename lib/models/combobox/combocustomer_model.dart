import 'package:equatable/equatable.dart';

class ComboCustomerModel extends Equatable {
  final String alamat1;
  final String alamat2;
  final String mrekanId;
  final String rekanNama;
  final String telp1;
  final String telp2;
  final String titleDesc;
  final String custCatId;
  final String rekanType;

  const ComboCustomerModel(
      {this.alamat1 = '',
      this.alamat2 = '',
      this.mrekanId = '',
      this.rekanNama = '',
      this.telp1 = '',
      this.telp2 = '',
      this.titleDesc = "",
      this.custCatId = '',
      this.rekanType = ''});

  factory ComboCustomerModel.fromJson(Map<String, dynamic> data) =>
      ComboCustomerModel(
          mrekanId: data['mrekanId'],
          rekanNama: data['rekanNama'],
          alamat1: data['alamat1']??"",
          alamat2: data['alamat2']??"",
          telp1: data['telp1']??"",
          telp2: data['telp2']??"",
          titleDesc: data['titleDesc']??"",
          custCatId: data['custCatId']??"",
          rekanType: data['rekanType']??""
        );

  Map<String, dynamic> toJson() =>
    {'alamat1': alamat1,
		'alamat2': alamat2,
		'mrekanId': mrekanId,
		'rekanNama': rekanNama,
		'telp1': telp1,
		'telp2': telp2,
		'titleDesc': titleDesc,
		'custCatId': custCatId,
		'rekanType': rekanType
    };

  @override
  List<Object> get props => [alamat1, alamat2, mrekanId, rekanNama, telp1, telp2, titleDesc, custCatId, rekanType];
}
