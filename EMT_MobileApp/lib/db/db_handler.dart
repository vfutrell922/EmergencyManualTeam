import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:emergencymanual/model/log.dart';
import 'package:emergencymanual/model/protocol.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EMTAppDatabase {
  static final EMTAppDatabase instance = EMTAppDatabase._init();

  static Database? _database;

  final String dbfilePath = 'EMT_database.db';

  EMTAppDatabase._init();

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

  void deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbfilePath);
    await deleteDatabase(path);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final logDataType = 'TEXT NOT NULL';
    final NameType = 'TEXT NOT NULL';
    final CertificationType = 'INTEGER NOT NULL';
    final PatientTypeType = 'INTEGER NOT NULL';
    final GuidelineIdType = 'INTEGER NOT NULL';
    final GuidelineType = 'TEXT';
    final OLMCRequiredType = 'INTEGER NOT NULL';
    final HasAssociatedMedicationType = 'INTEGER';
    //TODO: is this right?
    final MedicationsType = 'TEXT';
    final ChartType = 'TEXT';
    final OtherInformationType = 'TEXT';
    final TreatmentPlanType = 'TEXT';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableLogs (
      ${LogFields.id} $idType,
      ${LogFields.logData} $logDataType
    );''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableProtocols (
      ${ProtocolFields.id} $idType,
      ${ProtocolFields.Name} $NameType,
      ${ProtocolFields.Certification} $CertificationType,
      ${ProtocolFields.PatientType} $PatientTypeType,
      ${ProtocolFields.GuidelineId} $GuidelineIdType,
      ${ProtocolFields.Guideline} $GuidelineType,
      ${ProtocolFields.OLMCRequired} $OLMCRequiredType,
      ${ProtocolFields.HasAssociatedMedication} $HasAssociatedMedicationType,
      ${ProtocolFields.Medications} $MedicationsType,
      ${ProtocolFields.Chart} $ChartType,
      ${ProtocolFields.OtherInformation} $OtherInformationType,
      ${ProtocolFields.TreatmentPlan} $TreatmentPlanType
    );''');
  }

  Future<Log> addLog(Log log) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, log.toJson());

    return log.copy(id: id);
  }

  Future<Protocol> addProtocol(Protocol protocol) async {
    final db = await instance.database;

    final id = await db.insert(tableProtocols, protocol.toJson());

    return protocol.copy(id: id);
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

  Future<Protocol> readProtocol(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLogs,
      columns: ProtocolFields.values,
      where: '${ProtocolFields.id} = ? ',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Protocol.fromJson(maps.first);
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

  Future<List<Protocol>> readAllProtocols() async {
    final db = await instance.database;

    final orderBy = '${ProtocolFields.id} ASC';

    final result = await db.query(tableProtocols, orderBy: orderBy);

    return result.map((json) => Protocol.fromJson(json)).toList();
  }

  Future<List<String>> readNonRepeatingProtocolNames() async {
    final db = await instance.database;

    final orderBy = '${ProtocolFields.id} ASC';

    final result =
        await db.query(tableProtocols, columns: ['Name'], orderBy: orderBy);
    List<String> ret = [];
    for (var obj in result) {
      String name = obj["Name"].toString();
      if (!ret.contains(name)) {
        ret.add(obj["Name"].toString());
      }
    }
    return ret;
  }

  Future<int> updateLog(Log log) async {
    final db = await instance.database;

    return db.update(tableLogs, log.toJson(),
        where: '$LogFields.id} = ?', whereArgs: [log.id]);
  }

  Future<int> updateProtocol(Protocol protocol) async {
    final db = await instance.database;

    return db.update(tableProtocols, protocol.toJson(),
        where: '$ProtocolFields.id} = ?', whereArgs: [protocol.id]);
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
