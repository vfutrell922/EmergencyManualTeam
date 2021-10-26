import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:emergencymanual/model/log.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' show JSON;

class LogDatabase {
  static final LogDatabase instance = LogDatabase._init();

  static Database? _database;

  final String dbfilePath = 'log_database.db';

  LogDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbfilePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final runNumType = 'INTEGER';
    final startTimeType = 'TEXT';
    final endTimeType = 'TEXT';
    final additionalDataType = 'TEXT';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableLogs (
      ${LogFields.id} $idType,
      ${LogFields.runNum} $runNumType,
      ${LogFields.startTime} $startTimeType,
      ${LogFields.endTime} $endTimeType,
      ${LogFields.additionalData} $additionalDataType
    );''');
  }

  Future<Log> add(Log log) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, log.toJson());

    return log.copy(id: id);
  }

  Future<Log> read(int id) async {
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

  Future<List<Log>> readAll() async {
    final db = await instance.database;

    final orderBy = '${LogFields.id} ASC';

    final result = await db.query(tableLogs, orderBy: orderBy);

    return result.map((json) => Log.fromJson(json)).toList();
  }

  // called anytime the log is running and they add more info
  // or if they go back and update info
  // TODO this will have a lot of backend work (or will need more specific functions) to differentiate what they're updating
  Future<void> additionalDataUpdate(String data) async {
    //TODO this stuff will eventually be global instead
    int hardId = 1;
    Log curLog = await LogDatabase.instance.read(hardId);
    print("this is the current log");
    print(curLog);

    Log updatedLog = curLog.copy(additionalData: data);
    await LogDatabase.instance.updateLog(curLog);
  }

  // Updates the log in the database
  Future<int> updateLog(Log log) async {
    final db = await instance.database;
    return db.update(tableLogs, log.toJson(),
        where: '${LogFields.id} = ?', whereArgs: [log.id]);
  }

  Future<int> deleteLog(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableLogs, where: '${LogFields.id} = ?', whereArgs: [id]);
  }

  // TODO method to add to json object for additional data
  dynamic appendAdditionalData(dynamic data) {
    // doesn't need to return anything
  }

  // sierra TODO need this?
  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    } // TODO have other types for meds, etc. to know what to add on end?
    return item;
  }

  // TODO method to parse data from additional data

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
