import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/database/user/user_database.dart';
import 'package:esalesapp/models/user/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int?> createUser(User user) async {
    final db = await dbProvider.database;
    Future<int>? result;
    try {
      result = db?.insert(userTable, user.toDatabaseJson());
    } catch (e) {
      debugPrint("createUser error : ${e.toString()}");
    }
    return result;
  }

  Future<int?> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db?.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<String> getUserToken(int id) async {
    final db = await dbProvider.database;
    String token = "";
    List<Map> users =
        await db!.query(userTable, where: 'id = ?', whereArgs: [id]);
    if (users.isNotEmpty) {
      token = users[0]["token"];
      AppData.userToken = token;
    }

    return token;
  }

  Future<bool> checkUser(int id) async {
    //debugPrint("func checkUser");
    final db = await dbProvider.database;

    //debugPrint("func checkUser -> get db");

    try {
      //debugPrint("func checkUser -> start -> cek users");

      List<Map> users =
          await db!.query(userTable, where: 'id = ?', whereArgs: [id]);

      //debugPrint("func checkUser cek users");

      if (users.isNotEmpty) {
        //debugPrint("func checkUser -> has user");

        AppData.userToken = users[0]["token"];
        AppData.userid = users[0]["username"];
        return true;
      } else {
        //debugPrint("func checkUser -> no user");

        return false;
      }
    } catch (error) {
      //debugPrint("error func checkUser");
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    //debugPrint("user_dao -> updateUser #10");

    final db = await dbProvider.database;
    try {
      await db!.update(
        userTable,
        user.toDatabaseJson(),
        where: "id = ?",
        whereArgs: [user.id],
      );
    } catch (error) {
      return false;
    }
    return true;
  }

  Future<bool> updateFoto(User user) async {
    //debugPrint("user_dao -> updateFoto #10");

    //debugPrint(user.id.toString());

    //debugPrint("user_dao -> updateFoto #20");

    //debugPrint(user.foto.toString());

    //debugPrint("user_dao -> updateFoto #30");

    final db = await dbProvider.database;
    try {
      await db!.update(
        userTable,
        user.toDatabaseJson(),
        where: "id = ?",
        whereArgs: [user.id],
      );
    } catch (error) {
      return false;
    }

    //debugPrint("user_dao -> updateFoto #40");

    return true;
  }

  Future<User> getUser(int id) async {
    final db = await dbProvider.database;

    User user;

    List<Map> users =
        await db!.query(userTable, where: 'id = ?', whereArgs: [id]);

    user = User(
        id: users[0]["id"],
        username: users[0]["username"],
        nama: users[0]["nama"],
        personId: users[0]["personId"],
        hp: users[0]["hp"],
        email: users[0]["email"],
        alamat1: users[0]["alamat1"],
        alamat2: users[0]["alamat2"],
        propinsiId: users[0]["propinsiId"],
        propinsiDesc: users[0]["propinsiDesc"],
        jnskel: users[0]["jnskel"],
        hasDownline: users[0]["hasDownline"],
        token: users[0]["token"],
        foto: users[0]["foto"]);

    return user;
  }

  Future<Uint8List> getUserFoto(int id) async {
    //debugPrint("user_dao -> getUserFoto #10");

    Uint8List foto;

    User user = await getUser(0);

    //debugPrint(user.nama);
    //debugPrint("user_dao -> getUserFoto #20");

    //debugPrint(user.toDatabaseJson().toString());

    //debugPrint("user_dao -> getUserFoto #30");

    if ((user.foto != null) && (user.foto!.isNotEmpty)) {
      //debugPrint("getUserFoto -> FOTO -> not NULL #32");
      foto = user.foto!;
      //debugPrint("getUserFoto -> FOTO -> not NULL #33");
      //debugPrint(foto.toString());
      //debugPrint("getUserFoto -> FOTO -> not NULL #34");
      //debugPrint(foto.lengthInBytes.toString());
    } else {
      ByteData bytes =
          await rootBundle.load("assets/images/icon-user-default.png");
      foto = bytes.buffer.asUint8List();
      //debugPrint("getUserFoto -> FOTO -> NULL #36");
    }

    //debugPrint("user_dao -> getUserFoto #40");

    return foto;
  }
}
