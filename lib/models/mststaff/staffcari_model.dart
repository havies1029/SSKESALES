class StaffCariModel {
  String alamat;
  String email;
  double gaji;
  String hp;
  String ktp;
  String mjabatanId;
  String? jabatanDesc;
  String mstaffId;
  String staffNama;
  double uangMakan;

  StaffCariModel(
      {required this.alamat,
      required this.email,
      required this.gaji,
      required this.hp,
      required this.ktp,
      required this.mjabatanId,
      this.jabatanDesc,
      required this.mstaffId,
      required this.staffNama,
      required this.uangMakan});

  factory StaffCariModel.fromJson(Map<String, dynamic> data) {

    return StaffCariModel(
        alamat: data['alamat'] ?? "",
        email: data['email'] ?? "",
        gaji: double.tryParse(data['gaji'].toString())??0,
        hp: data['hp'] ?? "",
        ktp: data['ktp'] ?? "",
        mjabatanId: data['mjabatanId'] ?? "",
        jabatanDesc: data['jabatanDesc'] ?? "",
        mstaffId: data['mstaffId'] ?? "",
        staffNama: data['staffNama'] ?? "",
        uangMakan: double.tryParse(data['uangMakan'].toString())??0
        );
  }

  Map<String, dynamic> toJson() => {
        'alamat': alamat,
        'email': email,
        'gaji': gaji.toString(),
        'hp': hp,
        'ktp': ktp,
        'mjabatanId': mjabatanId,
        'jabatanDesc': jabatanDesc,
        'mstaffId': mstaffId,
        'staffNama': staffNama,
        'uangMakan': uangMakan.toString()
      };
}
