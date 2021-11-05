import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'globals.dart' as globals;
import 'model/log.dart';
import 'db/logdb_handler.dart';
import 'oldlogspage.dart';

class LogBar extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

int _selectedIndex = 0;

class _LogState extends State<LogBar> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    return new BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Start',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_done_outlined),
            label: 'Stop',
            backgroundColor: Colors.red[400],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.preview_outlined),
            label: 'Review Logs',
            backgroundColor: Colors.blue[400],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            if (globals.currentLogID == -1) {
              globals.currentLogID = globals.nextLogID;
              globals.nextLogID++;
              addLog();
              print("enter");
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Current Log'),
                  content: const Text(
                      'A log is currently in progress. Would you like to start a new log?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Continue Current'),
                    ),
                    TextButton(
                      onPressed: () {
                        String valueText = "0";
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Save Old Log'),
                                content: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      valueText = value;
                                    });
                                  },
                                  controller: _textFieldController,
                                  decoration:
                                      InputDecoration(hintText: "Run Number"),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('CANCEL'),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context, 'New Log');
                                      setState(() {
                                        Navigator.pop(context);
                                        addRunNum(int.parse(valueText));
                                      });
                                      addLog();
                                      globals.currentLogID = globals.nextLogID;
                                      globals.nextLogID++;
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Text('Start New Log'),
                    ),
                  ],
                ),
              );
            }
          } else if (index == 1) {
            if (globals.currentLogID != -1) {
              String valueText = "0";
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Save Log'),
                      content: TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: _textFieldController,
                        decoration: InputDecoration(hintText: "Run Number"),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              addRunNum(int.parse(valueText));
                              globals.currentLogID = -1;
                            });
                          },
                        ),
                      ],
                    );
                  });
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('No Active Log'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('There is no in progress log.'),
                              Text('Please start a log to save.'),
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
          } else if (index == 2) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new OldLogsPage()),
            );
          }
        });
  }

  Future addLog() async {
    DateTime startTime = DateTime.now();
    String formattedTime = DateFormat.Hms().format(startTime);

    final log = Log(startTime: formattedTime);
    await LogDatabase.instance.add(log);
  }

  Future addRunNum(int runNumber) async {
    Log currentLog = await LogDatabase.instance.read(globals.currentLogID);
    Log newLog = currentLog.copy(runNum: runNumber);
    await LogDatabase.instance.updateLog(newLog);
  }
}
