// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
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
          title: Text('Testing'),
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
                children: [
                  ElevatedButton(
                    child: new Text("testing ${curLog.id}"),
                    // 3
                    onPressed: () => {
                      setState(() {
                        Colors.green[50];
                      })
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
