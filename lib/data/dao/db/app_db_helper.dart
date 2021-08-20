import 'dart:developer' as dev;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "mg.oplayer.db";
  static final _databaseVersion = 1;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    dev.log('init database');
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Song (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            singer TEXT,
            duration NUMBER,
            path TEXT NOT NULL,
            imgB64 TEXT
          )
          ''');
  }
}
