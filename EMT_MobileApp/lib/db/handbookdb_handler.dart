import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:emergencymanual/model/protocol.dart';
import 'package:emergencymanual/model/chart.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HandbookDatabase {
  static final HandbookDatabase instance = HandbookDatabase._init();

  static Database? _database;

  final String dbfilePath = 'handbook_database.db';

  HandbookDatabase._init();

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

  void clearProtocolTable() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbfilePath);

    Database db = await openDatabase(path, version: 1, onCreate: _createDB);
    await db.execute("DELETE FROM $tableProtocols");
  }

  void clearChartTable() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbfilePath);

    Database db = await openDatabase(path, version: 1, onCreate: _createDB);
    await db.execute("DELETE FROM $tableCharts");
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
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

    final PhotoType = 'BLOB NOT NULL';
    final IsQuickLinkType = 'INTEGER NOT NULL';
    final ChartProtocolType = 'TEXT';

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
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableCharts (
      ${ChartFields.id} $idType,
      ${ChartFields.Name} $NameType,
      ${ChartFields.Photo} $PhotoType,
      ${ChartFields.IsQuickLink} $IsQuickLinkType,
      ${ChartFields.Protocol} $ChartProtocolType
    );''');
  }

  Future<Protocol> addProtocol(Protocol protocol) async {
    final db = await instance.database;

    final id = await db.insert(tableProtocols, protocol.toJson());

    return protocol.copy(id: id);
  }

  Future<Chart> addChart(Chart chart) async {
    final db = await instance.database;

    final id = await db.insert(tableCharts, chart.toJson());

    return chart.copy(id: id);
  }

  Future<Protocol> readProtocol(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProtocols,
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

  Future<Chart> readChart(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCharts,
      columns: ChartFields.values,
      where: '${ChartFields.id} = ? ',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Chart.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Protocol>> readAllProtocols() async {
    final db = await instance.database;

    final orderBy = '${ProtocolFields.id} ASC';

    final result = await db.query(tableProtocols, orderBy: orderBy);

    return result.map((json) => Protocol.fromJson(json)).toList();
  }

  Future<List<Chart>> readAllCharts() async {
    final db = await instance.database;

    final orderBy = '${ChartFields.id} ASC';

    final result = await db.query(tableCharts, orderBy: orderBy);

    return result.map((json) => Chart.fromJson(json)).toList();
  }

  Future<List<String>> readNonRepeatingNames() async {
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

  Future<List<Protocol>> getProtocolsWithName(String name) async {
    final db = await instance.database;
    String whereString = '${ProtocolFields.Name} =?';
    List<dynamic> whereArguments = [name];
    final result = await db.query(tableProtocols,
        where: whereString, whereArgs: whereArguments);

    List<Protocol> protocols =
        List<Protocol>.from(result.map((model) => Protocol.fromJson(model)));
    debugPrint("Protocols with the specified name: " + protocols.toString());
    return protocols;
  }

  Future<int> updateProtocol(Protocol protocol) async {
    final db = await instance.database;

    return db.update(tableProtocols, protocol.toJson(),
        where: '$ProtocolFields.id} = ?', whereArgs: [protocol.id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
