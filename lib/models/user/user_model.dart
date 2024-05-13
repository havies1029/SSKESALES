import 'dart:typed_data';

class User {
  int? id;
  String? username;
  String? nama;
  String? hp;
  String? email;
  String? alamat1;
  String? alamat2;
  String? propinsiId;
  String? propinsiDesc;
  String? jnskel;
  String? token;
  Uint8List? foto;

  User(
      {this.id,
      this.username,
      this.nama,
      this.hp,
      this.email,
      this.alamat1,
      this.alamat2,
      this.propinsiId,
      this.propinsiDesc,
      this.jnskel,
      this.token,
      this.foto});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        nama: data['nama'],
        hp: data['hp'],
        email: data['email'],
        alamat1: data['alamat1']??'',
        alamat2: data['alamat2']??'',
        propinsiId: data['propinsiId']??'',
        propinsiDesc: data['propinsiDesc']??'',
        jnskel: data['jnskel']??'',
        foto: data['foto']??'',
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "username": username,
        "nama": nama,
        "hp": hp,
        "email": email,
        "alamat1": alamat1,
        "alamat2": alamat2,
        "propinsiId": propinsiId,
        "propinsiDesc": propinsiDesc,
        "jnskel": jnskel,
        "foto": foto,
        "token": token
      };
}
