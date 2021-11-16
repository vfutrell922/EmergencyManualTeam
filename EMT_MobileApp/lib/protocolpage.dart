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
import 'globals.dart' as globals;

class ProtocolPage extends StatefulWidget {
  final String name;

  ProtocolPage(@required this.name);

  @override
  _ProtocolState createState() => _ProtocolState();
}

class _ProtocolState extends State<ProtocolPage> {
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
              return specificPage();
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future<List<Protocol>> SetUp() async {
    debugPrint("Setting up protocol page");
    await findCharts();
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

  String findProtocolWithCertification(int certification) {
    String protocol = "";
    _protocols.forEach((element) {
      if (element.Certification == certification) {
        if (element.PatientType == 0) {
          protocol += "<p><b>Adult</b></p>";
        } else if (element.PatientType == 1) {
          protocol += "<p><b>Pediatric</b></p>";
        } else if (element.PatientType == 2) {
          protocol += "<p><b>All Ages</b></p>";
        }
        if (element.TreatmentPlan != Null) {
          protocol += ("<p><b>Treatment Plan</b></p>" +
              element.TreatmentPlan.toString() +
              "<p></p>");
        }
        if (element.OtherInformation != Null) {
          protocol += ("<p><b>Other Information</b></p>" +
              element.OtherInformation.toString() +
              "<p></p>");
        }
      }
    });
    return protocol;
  }

  List displayAllCharts() {
    List<Widget> ret = [];
    for (Chart chart in _charts) {
      ret.add(
        Text(chart.Name),
      );
      ret.add(InteractiveViewer(
        child: Image.memory(chart.Photo),
        maxScale: 5.0,
      ));
    }
    return ret;
  }

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

  Future<List<Medication>> findMedicationsForCertification(
      int certification) async {
    List<String> medIDs = [];
    _protocols.forEach((element) {
      if (element.Certification == certification &&
          element.HasAssociatedMedication == 1 &&
          element.Medications != null) {
        medIDs.add(element.Medications.toString());
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
            await HandbookDatabase.instance.readMedicationServerID(element.ID);
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
                  child: ListView.builder(
                      itemCount: medications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: new GestureDetector(
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
                          },
                          child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(172, 206, 242, 1),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: new Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Container(
                                          child: Text(
                                            '${medications[index].Name}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.0),
                                                  topRight:
                                                      Radius.circular(15.0))),
                                        ),
                                        new GestureDetector(
                                          onTap: () {
                                            if (globals.currentLogID != -1) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      title: Text(
                                                          'Add Medication'),
                                                      content: StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                        return Form(
                                                          key: _formKey,
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                TextFormField(
                                                                  controller:
                                                                      _textFieldController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              "Dosage"),
                                                                  onSaved:
                                                                      (value) {
                                                                    dosage =
                                                                        value!;
                                                                  },
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      dosage =
                                                                          value;
                                                                    });
                                                                  },
                                                                  validator:
                                                                      (String?
                                                                          value) {
                                                                    return (value ==
                                                                                null ||
                                                                            value.isEmpty)
                                                                        ? 'Please Insert Dosage.'
                                                                        : null;
                                                                  },
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16),
                                                                  child:
                                                                      DropDownFormField(
                                                                    titleText:
                                                                        'Route',
                                                                    hintText:
                                                                        'Insert Route',
                                                                    value:
                                                                        _myRoute,
                                                                    onSaved:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myRoute =
                                                                            value;
                                                                      });
                                                                    },
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myRoute =
                                                                            value;
                                                                      });
                                                                    },
                                                                    dataSource: [
                                                                      {
                                                                        "display":
                                                                            "IM",
                                                                        "value":
                                                                            "IM",
                                                                      },
                                                                      {
                                                                        "display":
                                                                            "IV",
                                                                        "value":
                                                                            "IV",
                                                                      },
                                                                      {
                                                                        "display":
                                                                            "IO",
                                                                        "value":
                                                                            "IO",
                                                                      },
                                                                      {
                                                                        "display":
                                                                            "NEB",
                                                                        "value":
                                                                            "NEB",
                                                                      },
                                                                    ],
                                                                    textField:
                                                                        'display',
                                                                    valueField:
                                                                        'value',
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          16.0),
                                                                  child:
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              addMedication('${medications[index].Name}', dosage, _myRoute);
                                                                            }
                                                                            _textFieldController.clear();
                                                                            Navigator.of(context).pop();
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'No Active Log'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: const <
                                                                    Widget>[
                                                                  Text(
                                                                      'There is no in progress log.'),
                                                                  Text(
                                                                      'Please start a log to add a medication.'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text(
                                                                    'Cancel'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ));
                                            }
                                          },
                                          child: new Container(
                                              margin: const EdgeInsets.all(0.0),
                                              child: new Icon(
                                                Icons.local_phone,
                                                color: Colors.red,
                                                size: 30.0,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 0.0),
                                    child: Container(
                                      height: 5.0,
                                    ),
                                  ),
                                ],
                              )),
                        ));
                      }));
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget specificPage() {
    return DefaultTabController(
        initialIndex: 1,
        length: 5,
        child: Scaffold(
          floatingActionButton: PhoneButton(context),
          bottomNavigationBar: LogBar(),
          appBar: AppBar(
              backgroundColor: Color(0xFFFFFF),
              title: Text(widget.name),
              bottom: new TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: [
                  new Container(
                    color: Colors.yellow,
                    child: new Tab(
                      child: Text("General"),
                    ),
                  ),
                  new Container(
                    color: Colors.blue,
                    child: new Tab(
                      child: Text("EMT"),
                    ),
                  ),
                  new Container(
                    color: Colors.green,
                    child: new Tab(
                      child: Text("AEMT"),
                    ),
                  ),
                  new Container(
                    color: Colors.red,
                    child: new Tab(
                      child: Text("Paramedic"),
                    ),
                  ),
                  new Container(
                    color: Colors.grey,
                    child: new Tab(
                      child: Text("Charts"),
                    ),
                  ),
                ],
              )),
          body: TabBarView(
            children: <Widget>[
              Scaffold(
                  endDrawer: MedDrawer(3),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    title: Text(
                      "General",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: new Container(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Html(
                        data: findProtocolWithCertification(3),
                      ),
                    ),
                  )),
              Scaffold(
                  endDrawer: MedDrawer(0),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                    title: Text(
                      "EMT",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: new Container(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Html(data: findProtocolWithCertification(0)),
                    ),
                  )),
              Scaffold(
                  endDrawer: MedDrawer(1),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    title: Text(
                      "AEMT",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: new Container(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Html(data: findProtocolWithCertification(1)),
                    ),
                  )),
              Scaffold(
                  endDrawer: MedDrawer(2),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                    title: Text(
                      "Paramedic",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: new Container(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Html(data: findProtocolWithCertification(2)),
                    ),
                  )),
              Scaffold(
                endDrawer: MedDrawer(-1),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  title: Text(
                    "Charts",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: new SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: Column(
                    children: <Widget>[
                      ...displayAllCharts(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
