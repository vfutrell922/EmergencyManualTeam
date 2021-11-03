// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'db/handbookdb_handler.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'globals.dart' as globals;

import 'model/log.dart';
import 'package:flutter_html/flutter_html.dart';

class ProtocolPage extends StatefulWidget {
  final String name;

  ProtocolPage(@required this.name);

  @override
  _ProtocolState createState() => _ProtocolState();
}

class _ProtocolState extends State<ProtocolPage> {
  late List<Protocol> _protocols;
  late List<Chart> _charts;

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
    return await findProtocols();
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

  Widget specificPage() {
    return DefaultTabController(
        initialIndex: 1,
        length: 5,
        child: Scaffold(
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
