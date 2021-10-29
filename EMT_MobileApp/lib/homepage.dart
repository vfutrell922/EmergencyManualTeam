// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'quicklinkspage.dart';
import 'oldlogspage.dart';
import 'searchprotocolspage.dart';
import 'newlog.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as globals;

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class LogBar extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

int _selectedIndex = 0;

class _HomeState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Medication 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
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
        backgroundColor: Colors.green,
      ),
    );
  }
}

class HomePagePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - (screenWidth * .1)) / 2;
    double buttonHeight = buttonWidth * 0.5;
    return new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Image.asset('assets/images/logo.png', height: 300, width: 300),
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
                            //TODO sierra example
                            builder: (context) => new LogPage()),
                      );
                    },
                    child: new Text("Start New Log"),
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
                            builder: (context) => new OldLogsPage()),
                      );
                    },
                    child: new Text(
                      "View Old Logs",
                    ),
                  ),
                ),
              ]),
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
                  child: new Text(
                    "Protocols",
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
                  child: new Text(
                    "Quick Links",
                  ),
                ),
              )
            ],
          ),
        ]));
  }
}

class _LogState extends State<LogBar> {
  void initState() {
    globals.initNextLogID();
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
              addLog();
              globals.currentLogID = globals.nextLogID;
              globals.nextLogID++;
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
