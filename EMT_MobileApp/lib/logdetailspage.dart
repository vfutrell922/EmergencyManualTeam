// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'package:emergencymanual/icons.dart';
import 'model/log.dart';

class LogDetailsPage extends StatefulWidget {
  final Log curLog;
  LogDetailsPage({required this.curLog});

  @override
  _LogDetailsState createState() => _LogDetailsState(curLog: curLog);
}

class LogBar extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

int _selectedIndex = 0;

class _LogDetailsState extends State<LogDetailsPage> {
  final Log curLog;
  //TODO not sure if this is the best way to pass a log from oldLogsPage..
  _LogDetailsState({required this.curLog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run Number: ${curLog.runNum}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit Log',
              onPressed: () {}
              // TODO handle the press (create edit pop-up)
              ),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Log',
              onPressed: () {} //TODO handle the press (create delete pop-up)
              )
        ],
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                new Text("Date Performed: March 10, 2021")
              ], //TODO change this?
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // TODO here is where we will put the other info too
              children: [new Text("Runtime: ${curLog.runTime}")],
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogBar(),
    );
  }
}

class _LogState extends State<LogBar> {
  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        });
  }
}
