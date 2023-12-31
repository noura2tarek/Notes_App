import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/note_model.dart';
import 'dart:developer';

class SqlDB {
  final String _dbName = "notes.db";
  final String _dbTable = "Notes";
  static Database? _db;

  // Getter to read private db in sqlDB class
  // This function we use from the class to ensure that the database is initialized only once
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  //initialize function to initialize database, this will be called only once to create database
  // if we want to add table or edit table structure , version will change and the method (onUpgrade) will be called

  Future<Database> initDB() async {
    //Get a Database Location using getDataBasePath from ios or android phone
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName); // 'databasePath/notes.db'
    Database myDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return myDatabase;
  }

  // onCreate method execute only once  in the start to create database
  /*--------------------------  Create Database -----------------------------*/
  _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $_dbTable(
     "id" INTEGER PRIMARY KEY AUTOINCREMENT,
     "title" TEXT,
     "content" TEXT NOT NULL
     )
     ''').then((value) => log('Database and table created ============'));
    // the above statement creates table whose name is Notes in database.
    // To make another table execute another sql statement
  }

  /*--------------------------  Upgrade Database -----------------------------*/
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    //add a new column or drop column use on upgrade but first change the version of database
    //or delete all database and create it another time.
    await db.execute("ALTER TABLE $_dbTable ADD COLUMN color TEXT");
    log('Database upgraded ============');
  }

  //CREATE done
  //SELECT to read data
  /*--------------------------  Read All Data (Notes)  -----------------------------*/
  Future<List<Note>> readDB({String? where}) async {
    Database? mydb = await db;
    List<Map<String, Object?>>? response =
        await mydb?.query(_dbTable, where: where);
    var list = response!.map((e) => Note.fromMap(e)).toList();
    return list;
  }

  // insert data (row level)
  /*--------------------------  Insert Note  -----------------------------*/
  Future<int?> insertToDB({required Note note}) async {
    Database? mydb = await db;
    //Insert Function return 0 if an error occurred, and return the row number it inserts if the function completed normally.
    int? response = await mydb?.insert(_dbTable, note.toMap());
    return response;
  }

  // update data (column level)
  /*--------------------------  Update Note  -----------------------------*/
  Future<int?> updateDB({required Note note}) async {
    Database? mydb = await db;
    int? response =
        await mydb!.update(_dbTable, note.toMap(), where: "id = ${note.id}");
    return response;
  }

  /*--------------------------  Delete Note  -----------------------------*/
  Future<int?> deleteFromDB({required int id}) async {
    Database? mydb = await db;
    int response = await mydb!.delete(_dbTable, where: "id = $id");
    return response;
  }

  // delete all database except the structure of it
  /*--------------------------  Delete Database  -----------------------------*/
  deleteMyDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    await deleteDatabase(path);
  }
}
