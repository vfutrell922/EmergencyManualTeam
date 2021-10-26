// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quicklinkspage.dart';
import 'oldlogspage.dart';
import 'searchprotocolspage.dart';
import 'newlog.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
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
const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: Home',
    style: optionStyle,
  ),
  Text(
    'Index 1: Business',
    style: optionStyle,
  ),
];

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Emergency Manual'),
          centerTitle: true,
          backgroundColor: Color(0xFFFFFF),
        ),
        body: HomePagePanel(),
        bottomNavigationBar: LogBar());
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
              print(globals.nextLogID);
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
                        globals.currentLogID = globals.nextLogID;
                        globals.nextLogID++;
                        print(globals.nextLogID);
                        Navigator.pop(context, 'New Log');
                      },
                      child: const Text('Start New Log'),
                    ),
                  ],
                ),
              );
            }
          } else if (index == 1) {
            globals.currentLogID = -1;
          } else if (index == 2) {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new OldLogsPage()),
            );
          }
        });
  }

  Future addLog() async {
    final log = Log(
      runTime: "00:00:00",
    );

    await LogDatabase.instance.add(log);
  }
}
