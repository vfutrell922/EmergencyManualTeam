// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/handbookdb_handler.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'package:flutter_html/flutter_html.dart';
import 'logbar.dart';
import 'db/logdb_handler.dart';
import 'phonepage.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'certificationtabbar.dart';
import 'globals.dart' as globals;

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

  /// Adds a medication to the current log database entry
  Future addMedication(String name, String dosageInfo, String routeInfo) async {
    DateTime startTime = DateTime.now();
    String formattedTime = DateFormat.Hms().format(startTime);
    medLog newMedication = new medLog(
        type: name,
        dosage: dosageInfo,
        route: routeInfo,
        timeStamp: formattedTime);
    dynamic jsonString = newMedication.toJson();
    await LogDatabase.instance
        .additionalDataUpdate((jsonString.toString()), true);
  }

  /// Grab the ids for a specific certification as a list
  Future<List<Medication>> findMedicationsForCertification(
      int certification) async {
    List<String> medIDs = [];
    _protocols.forEach((element) {
      if (element.Certification == certification &&
          element.HasAssociatedMedication == 1 &&
          element.Medications != null) {
        List<String> t = element.Medications.toString()
            .replaceAll(new RegExp(r'[{}]'), '')
            .split(",");
        t.removeWhere((element) => element == '');
        debugPrint("Protocol has medications: " +
            t.toString() +
            " for certification: " +
            certification.toString());
        medIDs = t;
      }
    });

    List<Medication> medications = [];

    _medications.forEach((element) async {
      if (medIDs.contains(element.ID.toString())) {
        Medication validMedication =
            await HandbookDatabase.instance.readMedication(element.ID);
        medications.add(validMedication);
      }
    });

    return medications;
  }

  Widget MedDrawer(int certification) {
    TextEditingController _textFieldController = TextEditingController();
    return FutureBuilder(
        future: findMedicationsForCertification(certification),
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
              List<Medication> medications = snapshot.data as List<Medication>;
              String dosage = "";
              String _myRoute = '';
              final _formKey = GlobalKey<FormState>();
              return Drawer(
                  // Add a ListView to the drawer. This ensures the user can scroll
                  // through the options in the drawer if there isn't enough vertical
                  // space to fit everything.
                  child: ListView.builder(
                      itemCount: medications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                            title: Text('${medications[index].Name}'),
                            onTap: () {
                              if (globals.currentLogID != -1) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text('Add Medication'),
                                        content: StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                          return Form(
                                            key: _formKey,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        _textFieldController,
                                                    decoration: InputDecoration(
                                                        hintText: "Dosage"),
                                                    onSaved: (value) {
                                                      dosage = value!;
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dosage = value;
                                                      });
                                                    },
                                                    validator: (String? value) {
                                                      return (value == null ||
                                                              value.isEmpty)
                                                          ? 'Please Insert Dosage.'
                                                          : null;
                                                    },
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(16),
                                                    child: DropDownFormField(
                                                      titleText: 'Route',
                                                      hintText: 'Insert Route',
                                                      value: _myRoute,
                                                      onSaved: (value) {
                                                        setState(() {
                                                          _myRoute = value;
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _myRoute = value;
                                                        });
                                                      },
                                                      dataSource: [
                                                        {
                                                          "display": "IM",
                                                          "value": "IM",
                                                        },
                                                        {
                                                          "display": "IV",
                                                          "value": "IV",
                                                        },
                                                        {
                                                          "display": "IO",
                                                          "value": "IO",
                                                        },
                                                        {
                                                          "display": "NEB",
                                                          "value": "NEB",
                                                        },
                                                      ],
                                                      textField: 'display',
                                                      valueField: 'value',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            addMedication(
                                                                '${medications[index].Name}',
                                                                dosage,
                                                                _myRoute);
                                                          }
                                                          _textFieldController
                                                              .clear();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Save')),
                                                  )
                                                ]),
                                          );
                                        }));
                                  },
                                );
                              } else {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('No Active Log'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                Text(
                                                    'There is no in progress log.'),
                                                Text(
                                                    'Please start a log to add a medication.'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ));
                              }
                            });
                      }));
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
