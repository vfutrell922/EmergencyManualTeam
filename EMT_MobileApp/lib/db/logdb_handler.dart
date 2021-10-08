import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:emergencymanual/model/log.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    final patientIDType = 'TEXT';
    final unitNumType = 'INTEGER';
    final runTimeType = 'TEXT';
    final additionalDataType = 'TEXT';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableLogs (
      ${LogFields.id} $idType,
      ${LogFields.runNum} $runNumType,
      ${LogFields.patientID} $patientIDType,
      ${LogFields.unitNum} $unitNumType,
      ${LogFields.runTime} $runTimeType,
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

  Future<int> updateLog(Log log) async {
    final db = await instance.database;

    return db.update(tableLogs, log.toJson(),
        where: '$LogFields.runNum} = ?', whereArgs: [log.runNum]);
  }

  Future<int> deleteLog(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableLogs, where: '${LogFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
