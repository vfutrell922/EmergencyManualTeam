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

  Future addMedication(int medicationID) async {
    String medication = '';
    DateTime startTime = DateTime.now();
    String formattedTime = DateFormat.Hms().format(startTime);
    medLog newMedication = new medLog(
        type: "Tylonel", dosage: "40mg", route: "IO", timeStamp: formattedTime);
    dynamic jsonString = newMedication.toJson(formattedTime);
    await LogDatabase.instance.additionalDataUpdate((jsonString.toString()));
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
        String tester = t.toString();
        debugPrint("Protocol has medications: " +
            t.toString() +
            " for certification: " +
            certification.toString());
        medIDs = t;
      }
    });

    //TODO: next step is to check the ids of medications for the ones we're looking for

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
              return Drawer(
                  // Add a ListView to the drawer. This ensures the user can scroll
                  // through the options in the drawer if there isn't enough vertical
                  // space to fit everything.
                  child: ListView.builder(
                      itemCount: medications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                          title: Text('${medications[index].Name}'),
                          onTap: () {},
                        );
                      })
                  // ListView(
                  //   // Important: Remove any padding from the ListView.
                  //   padding: EdgeInsets.zero,
                  //   children: [
                  //     const DrawerHeader(
                  //       decoration: BoxDecoration(
                  //         color: Colors.blue,
                  //       ),
                  //       child: Text('Medications'),
                  //     ),
                  //     ListTile(
                  //       title: const Text('Medication 1'),
                  //       onTap: () {
                  //         addMedication(1);
                  //         debugPrint("numer1");
                  //         Navigator.pop(context);
                  //       },
                  //     ),
                  //     ListTile(
                  //       title: const Text('Medication 2'),
                  //       onTap: () {
                  //         addMedication(2);
                  //         Navigator.pop(context);
                  //       },
                  //     ),
                  //   ],
                  // ),
                  );
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
