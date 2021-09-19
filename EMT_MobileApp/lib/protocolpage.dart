// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';

class ProtocolPage extends StatefulWidget {
  @override
  _ProtocolState createState() => _ProtocolState();
}

class _ProtocolState extends State<ProtocolPage> {
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color(0xFFFFFF),
              title: Text("Cardiac Arrest"),
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
                body: Text('This is general info about cardiac arrest.'),
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
                body: Text('This is EMT info about cardiac arrest.'),
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
                body: Text('This is AEMT info about cardiac arrest.'),
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
                body: Text('This is Paramedic info about cardiac arrest.'),
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
                body: Text('These are relevant charts for cardiac arrest'),
              ),
            ],
          ),
        ));
  }
}
