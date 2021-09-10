import 'dart:async';

import 'package:emergencymanual/model/log.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class logDatabase {
  static final logDatabase instance = logDatabase._init();

  static Database? _database;

  logDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('log_database.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final logDataType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $tableLogs (
      ${LogFields.id} $idType,
      ${LogFields.logData} $logDataType
    )
    ''');
  }

  Future<Log> create(Log log) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, log.toJson());

    return log.copy(id: id);
  }

  Future<Log> readLog(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLogs,
      columns: LogFields.values,
      where: '${LogFields.id} = ? ',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Log.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Log>> readAllLogs() async {
    final db = await instance.database;

    final orderBy = '${LogFields.id} ASC';

    final result = await db.query(tableLogs, orderBy: orderBy);

    return result.map((json) => Log.fromJson(json)).toList();
  }

  Future<int> update(Log log) async {
    final db = await instance.database;

    return db.update(tableLogs, log.toJson(),
        where: '$LogFields.id} = ?', whereArgs: [log.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableLogs, where: '${LogFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
