import 'dart:async';

import 'package:emergencymanual/model/log.dart';
import 'package:emergencymanual/model/protocol.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EmtAppDatabase {
  static final EmtAppDatabase instance = EmtAppDatabase._init();

  static Database? _database;

  EmtAppDatabase._init();

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
    final NameType = 'TEXT NOT NULL';
    final CertificationType = 'TEXT NOT NULL';
    final PatientTypeType = 'INTEGER NOT NULL';
    final GuidelineIdType = 'INTEGER NOT NULL';
    final GuidelineType = 'TEXT NOT NULL';
    final OLMCRequiredType = 'BOOL NOT NULL';
    final HasAssociatedMedicationType = 'BOOL';
    //TODO: is this right?
    final MedicationsType = 'LIST OF TEXT';
    final ChartType = 'TEXT';
    final OtherInformationType = 'TEXT';
    final TreatmentPlanType = 'TEXT';

    await db.execute('''
    CREATE TABLE $tableLogs (
      ${LogFields.id} $idType,
      ${LogFields.logData} $logDataType
    )
    CREATE TABLE $tableProtocols (
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
    )
    ''');
  }

  Future<Log> addLog(Log log) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, log.toJson());

    return log.copy(id: id);
  }

  Future<Protocol> addProtocol(Protocol protocol) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, protocol.toJson());

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

  Future<Log> readProtocol(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLogs,
      columns: ProtocolFields.values,
      where: '${ProtocolFields.id} = ? ',
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

  Future<List<Log>> readAllProtocols() async {
    final db = await instance.database;

    final orderBy = '${ProtocolFields.id} ASC';

    final result = await db.query(tableProtocols, orderBy: orderBy);

    return result.map((json) => Log.fromJson(json)).toList();
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
