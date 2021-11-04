// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/logdb_handler.dart';
import 'quicklinkspage.dart';
import 'searchprotocolspage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'logbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class medLogFields {
  static final List<String> values = [
    type,
    dosage,
    route,
    timeStamp,
  ];
  static final String type = 'type';
  static final String dosage = 'dosage';
  static final String route = 'route';
  static final String timeStamp = 'timeStamp';
}

class medLog {
  final String? type;
  final String? dosage;
  final String? route;
  final String? timeStamp;

  const medLog({this.type, this.dosage, this.route, this.timeStamp});

  Map<String, dynamic> toJson() => {
        medLogFields.type: 'Medication',
        medLogFields.dosage: '50mg',
        medLogFields.route: 'LT',
        medLogFields.timeStamp: 'rn',
      };
  static medLog fromWebJson(Map<String, Object?> json) => medLog(
        type: json[medLogFields.type] as String?,
        dosage: json[medLogFields.dosage] as String,
        route: json[medLogFields.route] as String,
        timeStamp: json[medLogFields.timeStamp] as String,
      );
}

class _HomeState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Emergency Manual'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: HomePagePanel(),
      bottomNavigationBar: LogBar(),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Medications'),
            ),
            ListTile(
              title: const Text('Medication 1'),
              onTap: () {
                addMedication(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Medication 2'),
              onTap: () {
                addMedication(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          launch("tel://18884475594");
        },
        child: const Icon(Icons.local_phone),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future addMedication(int medicationID) async {
    DateTime startTime = DateTime.now();
    String formattedTime = DateFormat.Hms().format(startTime);
    medLog newMedication = new medLog(
        type: "Tylonel", dosage: "40mg", route: "IO", timeStamp: formattedTime);
    dynamic jsonString = newMedication.toJson();
    await LogDatabase.instance
        .additionalDataUpdate((jsonString.toString()), true);
  }
}

class HomePagePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - (screenWidth * .1)) / 2;
    double buttonHeight = buttonWidth * 0.8;
    return new Center(
        child: new SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
          Image.asset('assets/images/logo.png', height: 250, width: 250),
          SizedBox(
            height: 100,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: new ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new SearchProtocolsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(31, 61, 155, 1)),
                  child: new Text(
                    "Protocols",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              new SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: new ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new QuickLinksPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(31, 61, 155, 1)),
                  child: new Text(
                    "Quick Links",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              )
            ],
          ),
        ])));
  }
}
