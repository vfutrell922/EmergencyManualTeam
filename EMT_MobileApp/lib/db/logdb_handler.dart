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

class medLog {
  final String? type;
  final String? dosage;
  final String? route;
  final String? timeStamp;

  const medLog({this.type, this.dosage, this.route, this.timeStamp});

  Map<String, dynamic> toJson() => {
        medLogFields.type: this.type,
        medLogFields.dosage: this.dosage,
        medLogFields.route: this.route,
        medLogFields.timeStamp: timeStamp,
      };
  static medLog fromJson(Map<String, Object?> json) => medLog(
        type: json[medLogFields.type] as String?,
        dosage: json[medLogFields.dosage] as String,
        route: json[medLogFields.route] as String,
        timeStamp: json[medLogFields.timeStamp] as String,
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
      List<Log> dbList = await LogDatabase.instance.readAll();
      List temp = [];

      for (int i = 0; i < dbList.length; i++) {
        temp.add(dbList[i].id.toString() + dbList[i].runNum.toString());
      }
      int stopHere = 0;
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
  // todo make data also optional
  Future<void> additionalDataUpdate(String data, bool add,
      [int prevLogID = 0, int index = 0]) async {
    Log curLog;
    if (globals.currentLogID != -1) {
      // adding data to current log
      curLog = await LogDatabase.instance.read(globals.currentLogID);
    } else {
      //modifying past data
      curLog = await LogDatabase.instance.read(prevLogID);
    }
    if (curLog.additionalData != null) {
      //Retrieves the current value from the log
      List<dynamic> jsonMeds =
          jsonDecode(curLog.additionalData!)["Medications"];
      //Creates new addtionDataLog using the previous
      additionalDataLog currentData =
          new additionalDataLog(Medications: jsonMeds.cast<String>());

      //Adds new data JSON to the medications
      List<String> newMeds = currentData.Medications;
      if (add) {
        newMeds.add(data);
      } else {
        newMeds.removeAt(index);
      }
      additionalDataLog newData = new additionalDataLog(Medications: newMeds);

      //Sends new logs to database
      Log updatedLog =
          curLog.copy(additionalData: jsonEncode(newData).toString());
      await LogDatabase.instance.updateLog(updatedLog);
    } else {
      //Initializes additionalDataLog
      additionalDataLog newDataLog = new additionalDataLog(Medications: [data]);

      //Creates JSON
      String newDataJson = jsonEncode(newDataLog).toString();

      //Sends to database
      Log updatedLog = curLog.copy(additionalData: newDataJson);
      await LogDatabase.instance.updateLog(updatedLog);
    }
    debugPrint("Addtional Data: ${curLog.additionalData}");
    print("Addtional Data: ${curLog.additionalData}");
  }

  Future<List> additionalDataDecode(int id) async {
    List<dynamic> givenMeds = [];
    Log curLog = await LogDatabase.instance.read(id);
    if (curLog.additionalData != null) {
      List<dynamic> jsonMeds =
          jsonDecode(curLog.additionalData!)["Medications"];
      List<dynamic> meds = [];
      for (int i = 0; i < jsonMeds.length; i++) {
        String med = jsonMeds[i];

        //med = med [];
        med = med.substring(1);
        med = med.substring(0, med.length - 1);

        //med.replaceAll(": ", ", ");

        String temp = med.split(": ").toString();

        List jsonParts = temp.split(", ");
        jsonParts[0] = jsonParts[0].substring(1);
        jsonParts[jsonParts.length - 1] = jsonParts[jsonParts.length - 1]
            .substring(0, jsonParts[jsonParts.length - 1].length - 1);

        List medParts = [];
        for (int i = 0; i < jsonParts.length; i++) {
          if (i % 2 == 1) {
            medParts.add(jsonParts[i]);
          }
        }

        meds.add(medParts);
      }

      return meds;
    }
    return [];
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

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
