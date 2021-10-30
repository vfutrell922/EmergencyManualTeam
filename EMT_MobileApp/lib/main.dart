// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'homepage.dart';
import 'httpservice.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'db/handbookdb_handler.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    collectHandbook();
    return MaterialApp(
      title: 'EMT Manual',
      home: HomePage(),
    );
  }

  Future<bool> collectHandbook() async {
    debugPrint("Getting protocols");
    HandbookDatabase.instance.clearProtocolTable();
    httpService.getProtocols().then((List<Protocol> protocols) async {
      for (var i = 0; i < protocols.length; i++) {
        // debugPrint("Protocol Entry >>> " + protocols[i].toJson().toString());
        await HandbookDatabase.instance.addProtocol(protocols[i]);
      }
    });

    debugPrint("Getting charts");
    HandbookDatabase.instance.clearChartTable();
    httpService.getCharts().then((List<Chart> charts) async {
      for (var i = 0; i < charts.length; i++) {
        // debugPrint("Chart Entry >>> " + charts[i].toJson().toString());
        await HandbookDatabase.instance.addChart(charts[i]);
      }
    });

    // debugPrint("Getting medication");
    // HandbookDatabase.instance.clearMedicationTable();
    // httpService.getMedications().then((List<Medication> medications) async {
    //   for (var i = 0; i < medications.length; i++) {
    //     // debugPrint("Chart Entry >>> " + charts[i].toJson().toString());
    //     await HandbookDatabase.instance.addMedication(medications[i]);
    //   }
    // });

    return true;
  }
}
