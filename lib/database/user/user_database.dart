import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String userTable = 'userProfile';
//String pettyCash1Table = AppData.pettyCash1Table;
//String pettyCash2Table = AppData.pettyCash2Table;

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();

    return _database;
  }

  createDatabase() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "eplanner.db");

    debugPrint("SQLite Path : $path");

/*
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    */

    var database = await openDatabase(path);
    
    _createDb(database, 1);

    return database;
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $userTable ("
        "id INTEGER PRIMARY KEY, "
        "username TEXT, "
        "nama TEXT, "
        "hp TEXT, "
        "email TEXT, "
        "alamat1 TEXT, "
        "alamat2 TEXT, "
        "propinsiId TEXT, "
        "propinsiDesc TEXT, "
        "jnskel TEXT, "
        "token TEXT, "
        "foto BLOB "
        ")");
  }

  void _createDb(Database db, int newVersion) async {
    //await db.execute("drop table if exists $userTable");

    await db.execute('''
      create table if not exists $userTable (
        id integer primary key,
        username text not null,
        nama text not null,
        hp text,
        email text,
        alamat1 text,
        alamat2 text,
        propinsiId text,
        propinsiDesc text,
        jnskel text,
        token text not null,
        foto blob
      )''');

  }
}
