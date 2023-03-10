import 'package:database_bloc/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper? _databaseHelper; //SINGLETON DBHELPER
  StreamController<List<Map<String, dynamic>>>? _controller;
  DatabaseHelper._createInstance(); //NAMED CONST TO CREATE INSTANCE OF THE DBHELPER

  String noteTable = 'demo_table';
  String id = 'id';
  int? UniqueID;
  String name = 'name';

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get instance async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    //GET THE PATH TO THE DIRECTORY FOR IOS AND ANDROID TO STORE DB
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}NewDB.db";

    //OPEN/CREATE THE DB AT A GIVEN PATH

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $noteTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            UniqueID INTEGER NOT NULL DEFAULT 0,
            $name TEXT NOT NULL
          )
          ''');
  }

  //FETCH TO GET ALL NOTES
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await instance;
    var result = db.rawQuery("SELECT * FROM $noteTable");
//    var result = await db.query(noteTable, orderBy: "$colPriority ASC");  //WORKS THE SAME CALLED HELPER FUNC
    return result;
  }

  //INSERT OPS
  Future<int> insertNote(model note) async {
    Database db = await instance;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //GET THE NO:OF NOTES
  Future<int?> getCount() async {
    Database db = await instance;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT COUNT (*) FROM $noteTable");
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  //GET THE 'MAP LIST' [List<Map>] and CONVERT IT TO 'Note List' [List<Note>]
  Future<List<model>> getNoteList() async {
    var noteMapList = await getNoteMapList(); //GET THE MAPLIST FROM DB

    int count = noteMapList.length; //COUNT OF OBJS IN THE LIST
    print('FETCHING....$count');
    List<model> noteList = [];
    for (int index = 0; index < count; index++) {
      noteList.add(model.fromMap(noteMapList[index]));
    }
    return noteList;
  }

  Future<void> deleteTable(String name) async {
    print('deleting...');
    var db = await instance;
    await db.delete(noteTable, where: "name = ?", whereArgs: [name]);
    await db.query(noteTable);
  }

  Future<void> close() async {
    Database db = await instance;
    await _controller!.close();
    await db.close();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await instance;

    return await db.query(noteTable);
  }
}
