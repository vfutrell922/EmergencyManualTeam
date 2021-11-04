import 'dart:async';
import 'package:emergencymanual/homepage.dart';
import 'package:flutter/foundation.dart';

import 'package:emergencymanual/model/log.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:emergencymanual/globals.dart' as globals;
import 'dart:convert';

class additionalDataLogFields {
  static final List<String> values = [
    Medications,
  ];
  static final String Medications = 'Medications';
}

class additionalDataLog {
  final List<String> Medications;

  const additionalDataLog({
    required this.Medications,
  });

  Map<String, dynamic> toJson() => {
        additionalDataLogFields.Medications: Medications,
      };
  static additionalDataLog fromJson(Map<String, Object?> json) =>
      additionalDataLog(
        Medications: json[additionalDataLogFields.Medications] as List<String>,
      );
}

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
    List<String> dataList = [];
    if (globals.currentLogID != -1) {
      Log curLog = await LogDatabase.instance.read(globals.currentLogID);
      if (curLog.additionalData != null) {
        //Retrieves the current value from the log
        List<dynamic> jsonMeds =
            jsonDecode(curLog.additionalData!)["Medications"];
        //Creates new addtionDataLog using the previous
        additionalDataLog currentData =
            new additionalDataLog(Medications: jsonMeds.cast<String>());

        //Adds new data JSON to the medications
        List<String> newMeds = currentData.Medications;
        newMeds.add(data);
        additionalDataLog newData = new additionalDataLog(Medications: newMeds);

        //Sends new logs to database
        Log updatedLog =
            curLog.copy(additionalData: jsonEncode(newData).toString());
        await LogDatabase.instance.updateLog(updatedLog);
      } else {
        //Initializes additionalDataLog
        additionalDataLog newDataLog =
            new additionalDataLog(Medications: [data]);

        //Creates JSON
        String newDataJson = jsonEncode(newDataLog).toString();

        //Sends to database
        Log updatedLog = curLog.copy(additionalData: newDataJson);
        await LogDatabase.instance.updateLog(updatedLog);
      }
      debugPrint("Addtional Data: ${curLog.additionalData}");
      print("Addtional Data: ${curLog.additionalData}");
    }
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
