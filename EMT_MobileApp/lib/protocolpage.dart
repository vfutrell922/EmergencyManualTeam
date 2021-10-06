// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'db/handbookdb_handler.dart';
import 'model/protocol.dart';

class ProtocolPage extends StatefulWidget {
  final String name;

  ProtocolPage(@required this.name);

  @override
  _ProtocolState createState() => _ProtocolState();
}

class _ProtocolState extends State<ProtocolPage> {
  late List<Protocol> _protocols;

  Future<List<Protocol>> findProtocols() async {
    List<Protocol> protocols =
        await HandbookDatabase.instance.getProtocolsWithName(widget.name);
    _protocols = protocols;
    return protocols;
  }

  String findProtocolWithCertification(int certification) {
    String protocol = "";
    _protocols.forEach((element) {
      if (element.Certification == certification) {
        if (element.PatientType == 0) {
          protocol += "Adult\n\n";
        } else if (element.PatientType == 1) {
          protocol += "Pediatric\n\n";
        } else if (element.PatientType == 2) {
          protocol += "All Ages\n\n";
        }
        if (element.TreatmentPlan != Null) {
          protocol += ("Treatment Plan\n\n" +
              element.TreatmentPlan.toString() +
              "\n\n");
        }
        if (element.OtherInformation != Null) {
          protocol += ("Other Information\n\n" +
              element.OtherInformation.toString() +
              "\n\n");
        }
      }
    });
    return protocol;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
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
        },
        future: findProtocols());
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
                body: new SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: new Text(findProtocolWithCertification(3)),
                ),
              ),
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
                body: new SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: new Text(findProtocolWithCertification(0)),
                ),
              ),
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
                body: new SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: new Text(findProtocolWithCertification(1)),
                ),
              ),
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
                body: new SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: new Text(findProtocolWithCertification(2)),
                ),
              ),
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
                  child:
                      new Text('These are relevant charts for cardiac arrest'),
                ),
              ),
            ],
          ),
        ));
  }
}
