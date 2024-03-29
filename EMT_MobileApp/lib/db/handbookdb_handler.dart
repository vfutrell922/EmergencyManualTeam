// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:emergencymanual/model/protocol.dart';
import 'package:emergencymanual/model/chart.dart';
import 'package:emergencymanual/model/medication.dart';
import 'package:emergencymanual/model/phonenumber.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HandbookDatabase {
  /// Database to hold the protocols, medications, charts, and phone numbers recieved from the web portal API
  static final HandbookDatabase instance = HandbookDatabase._init();

  static Database? _database;

  final String dbfilePath = 'handbookDB.db';

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

  /// Delete all the table data from the database
  void clearDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbfilePath);
    Database db = await openDatabase(path, version: 1, onCreate: _createDB);
    await db.execute("DELETE FROM $tableProtocols");
    await db.execute("DELETE FROM $tableCharts");
    await db.execute("DELETE FROM $tableMedications");
    await db.execute("DELETE FROM $tablePhoneNumbers");
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final NameType = 'TEXT NOT NULL';
    final CertificationType = 'INTEGER NOT NULL';
    final PatientTypeType = 'INTEGER NOT NULL';
    final GuidelineType = 'TEXT';
    final OLMCRequiredType = 'INTEGER NOT NULL';
    final HasAssociatedMedicationType = 'INTEGER';
    final MedicationsType = 'TEXT';
    final ChartType = 'TEXT';
    final OtherInformationType = 'TEXT';
    final TreatmentPlanType = 'TEXT';

    final PhotoType = 'BLOB NOT NULL';
    final IsQuickLinkType = 'INTEGER NOT NULL';
    final ChartProtocolType = 'TEXT';

    final medicationIDType = 'INTEGER NOT NULL';
    final ActionType = 'TEXT NOT NULL';
    final IndicationType = 'TEXT NOT NULL';
    final ContraindicationType = 'TEXT NOT NULL';
    final PrecautionType = 'TEXT NOT NULL';
    final AdverseEffectsType = 'TEXT NOT NULL';
    final AdultDosageType = 'TEXT';
    final ChildDosageType = 'TEXT';
    final MaxType = 'TEXT';

    final HospitalNameType = 'TEXT NOT NULL';
    final NumberType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableProtocols (
      ${ProtocolFields.id} $idType,
      ${ProtocolFields.Name} $NameType,
      ${ProtocolFields.Certification} $CertificationType,
      ${ProtocolFields.PatientType} $PatientTypeType,
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
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableMedications (
      ${MedicationFields.ID} $medicationIDType,
      ${MedicationFields.PrimaryKey} $idType,
      ${MedicationFields.Name} $NameType,
      ${MedicationFields.Action} $ActionType,
      ${MedicationFields.Indication} $IndicationType,
      ${MedicationFields.Contraindication} $ContraindicationType,
      ${MedicationFields.Precaution} $PrecautionType,
      ${MedicationFields.AdverseEffects} $AdverseEffectsType,
      ${MedicationFields.AdultDosage} $AdultDosageType,
      ${MedicationFields.ChildDosage} $ChildDosageType,
      ${MedicationFields.Max} $MaxType
    );''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tablePhoneNumbers (
      ${PhoneNumberFields.Id} $idType,
      ${PhoneNumberFields.hospitalName} $HospitalNameType,
      ${PhoneNumberFields.numberString} $NumberType
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

  Future<Medication> addMedication(Medication medication) async {
    final db = await instance.database;
    final id = await db.insert(tableMedications, medication.toJson());
    return medication.copy(ID: id);
  }

  Future<PhoneNumber> addPhoneNumber(PhoneNumber phonenum) async {
    final db = await instance.database;
    final id = await db.insert(tablePhoneNumbers, phonenum.toJson());

    return phonenum.copy(Id: id);
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

  Future<Medication> readMedication(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedications,
      columns: MedicationFields.values,
      where: '${MedicationFields.PrimaryKey} = ? ',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Medication.fromJson(maps.first);
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

  Future<List<Medication>> readAllMedications() async {
    final db = await instance.database;

    final orderBy = '${MedicationFields.PrimaryKey} ASC';

    final result = await db.query(tableMedications, orderBy: orderBy);

    return result.map((json) => Medication.fromJson(json)).toList();
  }

  Future<List<PhoneNumber>> readAllPhoneNumbers() async {
    final db = await instance.database;

    final orderBy = '${PhoneNumberFields.Id} ASC';

    final result = await db.query(tablePhoneNumbers, orderBy: orderBy);

    return result.map((json) => PhoneNumber.fromJson(json)).toList();
  }

  /// Get a list of the protocol names (non repeated)
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

  /// Find the charts that correspond to a specific protocol
  Future<List<Chart>> getChartsForProtocol(String ProtocolName) async {
    final db = await instance.database;
    String whereString = '${ChartFields.Protocol} =?';
    List<dynamic> whereArguments = [ProtocolName];
    final result = await db.query(tableCharts,
        where: whereString, whereArgs: whereArguments);

    List<Chart> charts =
        List<Chart>.from(result.map((model) => Chart.fromJson(model)));
    return charts;
  }

  /// Get the charts that have the quick link flag
  Future<List<Chart>> getQuickLinkCharts() async {
    final db = await instance.database;
    String whereString = '${ChartFields.IsQuickLink} =?';
    List<dynamic> whereArguments = [1];
    final result = await db.query(tableCharts,
        where: whereString, whereArgs: whereArguments);

    List<Chart> charts =
        List<Chart>.from(result.map((model) => Chart.fromJson(model)));
    debugPrint(
        "Returning quick link charts length: " + charts.length.toString());
    return charts;
  }

  /// Find the protocols with a certain name
  Future<List<Protocol>> getProtocolsWithName(String name) async {
    final db = await instance.database;
    String whereString = '${ProtocolFields.Name} =?';
    List<dynamic> whereArguments = [name];
    final result = await db.query(tableProtocols,
        where: whereString, whereArgs: whereArguments);

    List<Protocol> protocols =
        List<Protocol>.from(result.map((model) => Protocol.fromJson(model)));
    // debugPrint("Returning protocols " + protocols.length.toString());
    return protocols;
  }

  /// Get a subset of the medications with specified ids
  Future<List<Medication>> readMedicationsWithIDs(List<int> ids) async {
    final db = await instance.database;
    List<Medication> meds = [];
    ids.forEach((id) async {
      final maps = await db.query(
        tableMedications,
        columns: MedicationFields.values,
        where: '${MedicationFields.PrimaryKey} = ? ',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        meds.add(Medication.fromJson(maps.first));
      } else {
        throw Exception('ID $id not found');
      }
    });

    debugPrint("Returning medications with the ids " + ids.toString());
    return meds;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
