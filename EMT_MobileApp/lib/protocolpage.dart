// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'db/handbookdb_handler.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'certificationtabbar.dart';

class ProtocolPage extends StatefulWidget {
  final String name;

  ProtocolPage(@required this.name);

  @override
  _ProtocolState createState() => _ProtocolState(protocolname: name);
}

class _ProtocolState extends State<ProtocolPage> {
  final String protocolname;

  _ProtocolState({required this.protocolname});

  /// data properties
  late List<Protocol> _protocols;
  late List<Chart> _charts;
  late List<Medication> _medications;

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SetUp(),
        builder: (ctx, snapshot) {
          // Checking if future is resolved
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              return CertificationTabBar(
                  protocolname, _protocols, _charts, _medications);
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  /// Retreives the protocol information including charts and medications before the page loads.
  Future<List<Protocol>> SetUp() async {
    await findCharts();
    // retrieve the protocols before the medications
    return await findProtocols().then((value) async {
      return await findMedications().then((meds) async {
        return value;
      });
    });
  }

  Future<List<Protocol>> findProtocols() async {
    List<Protocol> protocols =
        await HandbookDatabase.instance.getProtocolsWithName(widget.name);
    _protocols = protocols;
    return protocols;
  }

  Future<List<Chart>> findCharts() async {
    List<Chart> charts =
        await HandbookDatabase.instance.getChartsForProtocol(widget.name);
    _charts = charts;
    return charts;
  }

  Future<List<Medication>> findMedications() async {
    List<Medication> medications =
        await HandbookDatabase.instance.readAllMedications();
    _medications = medications;
    return medications;
  }
}
