//import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/logic/models/weather_model.dart';

class DatabaseHelper {
  static const _databaseName = "weather_database.db";
  static const _databaseVersion = 1;

  static const table = "items";

  static const columnId = "id";
  static const columnTemp = "temp";
  static const columnCity = "city";
  static const columnCountry = 'country';
  static const columnDesc = "desc";
  static const columnIcon = "icon";
  // static const columnDate = "date";

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    //deleteDatabase(path); //Tämä kommenttiin, kun ei haluta tuhota

    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTemp TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnCountry TEXT NOT NULL,
            $columnDesc TEXT,
            $columnIcon TEXT NOT NULL,
       
            )''');
  }

  Future<int> insert(WeatherModel item) async {
    return await _db.insert(table, item.toMap());
  }

/*  Future<List<WeatherModel>> queryAllRows() async {
    final List<Map<String, dynamic>> maps = await _db.query(table);

    return List.generate(maps.length, (i) {
      return WeatherModel(
        id: maps[i]['id'],
        temp: maps[i]['temp'],
        city: maps[i]['city'],
        country: maps[i]['country'],
        desc: maps[i]['desc'],
        icon: maps[i]['icon'],
      );
    });
  }
  */

  Future<int> update(WeatherModel item) async {
    return await _db.update(
      table,
      item.toMap(),
      where: '$columnId = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
