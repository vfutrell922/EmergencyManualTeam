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

class _HomeState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Medic Manual'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: HomePagePanel(),
      bottomNavigationBar: LogBar(),
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
