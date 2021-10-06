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

class _LogDetailsState extends State<LogDetailsPage> {
  final Log curLog;
  //TODO not sure if this is the best way to pass a log from oldLogsPage..
  _LogDetailsState({required this.curLog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Run Number: ${curLog.id}'),
          centerTitle: true,
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
                // TODO here is where we will put the other info too
                children: [new Text("123: ${curLog.additionalData}")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text("12"),
                  ElevatedButton(
                    child: new Text(
                        "Edit ${curLog.patientID} and testing ${curLog.unitNum}"),
                    // 3
                    onPressed: () => {setState(() {})},
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
