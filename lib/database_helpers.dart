import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableProfiles = 'profiles';
final String columnId = '_id';
final String columnName = 'name';
final String columnUserPoint = 'userPoint';
final String columnComPoint = 'comPoint';
final String columnTiePoint = 'tiePoint';
final String columnOverallRound = 'overallRound';
final String columnWinningPercent = 'winningPercent';
final String columnPoints = 'points';
final String columnRank = 'rank';
final String columnCreatedTime = 'createdTime';
final String columnUpdatedTime = 'updatedTime';
// data model class
class Profile {
  int id;
  String name;
  int userPoint;
  int comPoint;
  int tiePoint;
  int overallRound;
  double winningPercent;
  int points;
  String rank;
  String createdTime;
  String updatedTime;

  Profile();

  // convenience constructor to create a Word object
  Profile.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    userPoint = map[columnUserPoint];
    comPoint = map[columnComPoint];
    tiePoint = map[columnTiePoint];
    overallRound = map[columnOverallRound];
    winningPercent = map[columnWinningPercent];
    points = map[columnPoints];
    rank = map[columnRank];
    createdTime = map[columnCreatedTime];
    updatedTime = map[columnUpdatedTime];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnUserPoint: userPoint,
      columnComPoint: comPoint,
      columnTiePoint: tiePoint,
      columnOverallRound: overallRound,
      columnWinningPercent: winningPercent,
      columnPoints: points,
      columnRank: rank,
      columnCreatedTime: createdTime,
      columnUpdatedTime: updatedTime
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "RSP_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 5;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableProfiles (
                $columnId INTEGER PRIMARY KEY,
                $columnName TEXT NOT NULL,
                $columnUserPoint INTEGER NOT NULL,
                $columnComPoint INTEGER NOT NULL,
                $columnTiePoint INTEGER NOT NULL,
                $columnOverallRound INTEGER NOT NULL,
                $columnWinningPercent DOUBLE NOT NULL,
                $columnPoints INTEGER NOT NULL,
                $columnRank TEXT,
                $columnCreatedTime TEXT,
                $columnUpdatedTime TEXT
              )
              ''');
  }

  // Database helper methods:

  Future<List> insert(Profile name) async {
    Database db = await database;
    await db.insert(tableProfiles, name.toMap());
    return null;
  }
  Future<List> update(Profile name, int id) async {
    print('updated');
    Database db = await this.database;
    await db.update(tableProfiles, name.toMap(), where: '$columnId = ?', whereArgs: [id]);
    List<Map> maps = await db.query(tableProfiles,
        columns: [columnId, columnName, columnUserPoint, columnComPoint, columnTiePoint, columnOverallRound,
          columnWinningPercent,columnPoints,columnRank,columnCreatedTime,columnUpdatedTime],
        where: '$columnId = ?',
        whereArgs: [id]);
    print(maps);
    return null;
  }
  Future<int> getCount() async{
    Database db = await this.database;
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM profiles'));
    return count;
  }
  Future<Profile> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableProfiles,
        columns: [columnId, columnName, columnUserPoint, columnComPoint, columnTiePoint, columnOverallRound,
          columnWinningPercent,columnPoints,columnRank,columnCreatedTime,columnUpdatedTime],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Profile.fromMap(maps.first);
    }
    return null;
  }
  Future<int> search(String username) async {
    print(username);
    Database db = await database;
    int result = Sqflite.firstIntValue(await db.query(tableProfiles,
        columns: [columnId],
        where: '$columnName = ?',
        whereArgs: [username]
    ));
    if(result != null){
      print('id in search fun $result');
      return result;
    }
    else
      return null;
  }
  Future<int> delete(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableProfiles WHERE $columnId = $id');
    return result;
  }
  Future<int> deleteall() async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableProfiles');
    print('deleted');
    return result;
  }
  Future<List> data() async{
    Database db = await this.database;
    List<Map> user = await db.rawQuery('SELECT * FROM $tableProfiles');
    return user;
  }
  Future<List> sort() async{
    Database db = await this.database;
    List<Map> user = await db.rawQuery('SELECT * FROM $tableProfiles ORDER BY $columnPoints DESC');
    return user;
  }
}